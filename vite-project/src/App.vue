<script setup lang="ts">
import SideBar from './components/SideBar/SideBar.vue';
import Header from './components/Header.vue';
</script>

<template>
  <div class="flex column">
    <Header />
  </div>
  <div class="flex">
    <SideBar />
    <router-view />
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
