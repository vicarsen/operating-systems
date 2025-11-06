// SPDX-License-Identifier: BSD-3-Clause

#include "page_mapper.h"
#include "utils.h"
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>

void do_map(unsigned int num_pages) {
  /* TODO: Obtain page size. */
  int page_size = getpagesize();

  /* TODO: Map pages in memory using mmap(). */
  void *ret = mmap(NULL, page_size * num_pages, PROT_NONE,
                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
}
