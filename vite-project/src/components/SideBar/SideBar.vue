<template>
  <div class="sidebar">
    <div v-for="item in sidebarItems" :key="item" class="sidebarItem">
      <h3>{{ item.folderName }}</h3>
      <div class="folderItems">
        <router-link v-for="hrefItem in item.mdNameList" :to="generatePath(item.filePath, hrefItem)">{{ hrefItem }}</router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue';
import { sidebarItems } from '../../../output.js';

const generatePath = (filePath, mdName) => {
  return `${filePath ? filePath : '/'}${mdName}`;
};

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
