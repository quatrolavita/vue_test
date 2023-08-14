import { createRouter, createWebHistory } from 'vue-router';
import TestMDGeneratorVue from '../components/TestMDGenerator.vue';
import { sidebarItems } from '../documentation/output.js';

const generatedRoutes = sidebarItems.map(
  ({
    folderName,
    mdNameList,
    filePath,
  }) => {
    return mdNameList.map((mdName: string) => {
      return {
        path: `${filePath ? filePath: '/' }${mdName}`,
        component: TestMDGeneratorVue,
        props: { filePath: `../src/documentation/${folderName}/${mdName}.md` }, // Pass props to the component
      };
    });
  }
).flat();


const router = createRouter({
  history: createWebHistory(),
  routes: generatedRoutes,
});

export default router;
