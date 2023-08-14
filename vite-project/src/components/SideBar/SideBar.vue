<template>
  <div class="sidebar">
    <div v-for="item in sidebarItems" :key="item" class="sidebarItem">
      <h3>{{ item.folderName }}</h3>
      <div class="folderItems">
        <a v-for="hrefItem in item.mdNameList">{{ hrefItem }}</a>
      </div>
    </div>
  </div>
</template>

<script setup>
import { sidebarItems } from '../../documentation/output.js';
</script>

<style scoped>
.sidebar {
  width: 480px;
  background-color: #242424;
  border-right: 1px solid #333333;

  /* Add more styling as needed */
}

.sidebarItem {
  padding: 24px;
  padding-bottom: 0px;
}
.folderItems {
  display: flex;
  flex-direction: column;
}
</style>
