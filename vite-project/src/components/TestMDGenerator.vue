<template>
  <div class="markdown-loader">
    <VueMarkdown :source="markdown" :options="options" />
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import VueMarkdown from 'vue-markdown-render';
import hljs from 'highlight.js';

const props = defineProps({
  filePath: String, // Path to the .md file
});

const markdown = ref('');

const loadMarkdown = () => {
  fetch(props.filePath)
    .then(response => response.text())
    .then(text => {
      markdown.value = text;
    })
    .catch(error => {
      console.error('Error loading Markdown file:', error);
    });
}

onMounted(async () => {
  loadMarkdown();
});

watch(() => props.filePath, () => {
  loadMarkdown();
});

const options = {
  highlight: function (str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return hljs.highlight(str, { language: lang }).value;
      } catch (__) { }
    }

    return '';
  },
};
</script>

<style>
/* Scoped styles for the component */
.markdown-loader {
  padding: 10px;
  padding-left: 80px;
  padding-right: 80px;
}
/*!
  Theme: GitHub Dark
  Description: Dark theme as seen on github.com
  Author: github.com
*/

.hljs {
  color: #c9d1d9;
  background: #0d1117;
}

.hljs-doctag,
.hljs-keyword,
.hljs-meta .hljs-keyword,
.hljs-template-tag,
.hljs-template-variable,
.hljs-type,
.hljs-variable.language_ {
  /* prettylights-syntax-keyword */
  color: #ff7b72;
}

.hljs-title,
.hljs-title.class_,
.hljs-title.class_.inherited__,
.hljs-title.function_ {
  /* prettylights-syntax-entity */
  color: #d2a8ff;
}

.hljs-attr,
.hljs-attribute,
.hljs-literal,
.hljs-meta,
.hljs-number,
.hljs-operator,
.hljs-variable,
.hljs-selector-attr,
.hljs-selector-class,
.hljs-selector-id {
  /* prettylights-syntax-constant */
  color: #79c0ff;
}

.hljs-regexp,
.hljs-string,
.hljs-meta .hljs-string {
  /* prettylights-syntax-string */
  color: #a5d6ff;
}

.hljs-built_in,
.hljs-symbol {
  /* prettylights-syntax-variable */
  color: #ffa657;
}

.hljs-comment,
.hljs-code,
.hljs-formula {
  /* prettylights-syntax-comment */
  color: #8b949e;
}

.hljs-name,
.hljs-quote,
.hljs-selector-tag,
.hljs-selector-pseudo {
  /* prettylights-syntax-entity-tag */
  color: #7ee787;
}

.hljs-subst {
  /* prettylights-syntax-storage-modifier-import */
  color: #c9d1d9;
}

.hljs-section {
  /* prettylights-syntax-markup-heading */
  color: #1f6feb;
  font-weight: bold;
}

.hljs-bullet {
  /* prettylights-syntax-markup-list */
  color: #f2cc60;
}

.hljs-emphasis {
  /* prettylights-syntax-markup-italic */
  color: #c9d1d9;
  font-style: italic;
}

.hljs-strong {
  /* prettylights-syntax-markup-bold */
  color: #c9d1d9;
  font-weight: bold;
}

.hljs-addition {
  /* prettylights-syntax-markup-inserted */
  color: #aff5b4;
  background-color: #033a16;
}

.hljs-deletion {
  /* prettylights-syntax-markup-deleted */
  color: #ffdcd7;
  background-color: #67060c;
}

.hljs-char.escape_,
.hljs-link,
.hljs-params,
.hljs-property,
.hljs-punctuation,
.hljs-tag {
  /* purposely ignored */
}
</style>
