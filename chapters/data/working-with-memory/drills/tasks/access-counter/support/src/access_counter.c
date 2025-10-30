// SPDX-License-Identifier: BSD-3-Clause

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#include "access_counter.h"
#include "utils.h"

struct page_info {
  int prot;
  void *start;
};

unsigned long counter;

#define MAX_PAGES 16
static struct page_info pages[MAX_PAGES];
static size_t num_pages;

/* This is useful for filling the contents when execution rights are provided.
 */
static void do_nothing(void) {}

/*
 * The actual SIGSEGV handler.
 */
static void access_handler(int signum, siginfo_t *si, void *arg) {
  long page_size = sysconf(_SC_PAGESIZE);
  void *start;
  int rc;
  unsigned int i;

  log_debug("Enter handler");

  counter++;

  if (signum != SIGSEGV) {
    fprintf(stderr, "Unable to handle signal %d (%s)\n", signum,
            strsignal(signum));
    return;
  }

  /* TODO: Obtain page start address in start variable. */
  start = si->si_addr;

  for (i = 0; i < num_pages; i++)
    if (pages[i].start == start)
      break;

  if (i >= num_pages && i < MAX_PAGES) {
    pages[i].start = start;
    pages[i].prot = PROT_NONE;
    num_pages += 1;
  }

  log_debug("i = %u", i);

  /* TODO: Update page protections with mprotect(). */
  if (pages[i].prot == PROT_NONE) {
    pages[i].prot = PROT_READ;
  } else if (!(pages[i].prot & PROT_WRITE)) {
    pages[i].prot |= PROT_WRITE;
  } else {
    pages[i].prot |= PROT_EXEC;
  }

  mprotect(start, page_size, pages[i].prot);
}

void register_sigsegv_handler(void) {
  struct sigaction sa;
  int rc;

  memset(&sa, 0, sizeof(sa));
  sa.sa_sigaction = access_handler;
  sa.sa_flags = SA_SIGINFO;

  rc = sigaction(SIGSEGV, &sa, NULL);
  DIE(rc < 0, "sigaction");
}
