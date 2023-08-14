<script setup lang="ts">
import VueMarkdown from './components/TestMDGenerator.vue';
import SideBar from './components/SideBar/SideBar.vue';
import Header from './components/Header.vue';
</script>

<template>
  <div class="flex column">
    <Header />
  </div>
  <div class="flex">
    <SideBar />
    <VueMarkdown filePath="src/documentation/general/constants.md" />
  </div>
</template>

<style scoped>
.flex {
  display: flex;
}
.column {
  flex-direction: column;
}
</style>
