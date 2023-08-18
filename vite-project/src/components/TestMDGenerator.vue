<template>
  <div class="markdown-loader" @click="testClick" v-html="renderMarkdown()" /> 
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import markdownIt from 'markdown-it';
import hljs from 'highlight.js';
import anchor from 'markdown-it-anchor';

const markdown = ref('');

const props = defineProps({
  filePath: String, // Path to the .md file
});

const md = markdownIt({
    highlight: function (str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return '<pre class="hljs"><button class="copyButton">Copy</button><code>' +
          hljs.highlight(str, { language: lang, ignoreIllegals: true }).value +
          '</code></pre>';
      } catch (__) { }
    }

    return '<pre class="hljs"><code>' + md.utils.escapeHtml(str) + '</code></pre>';
  },
  linkify: true,
  html: true,
})
md.use(anchor, {
});

const testClick = (e) => {
  if (e.target.className === 'copyButton') {
     const codeElement = e.target.nextElementSibling;
    if (codeElement) {
      copyCode(codeElement);
    }
  }
}

const copyCode = (element) => {
  const range = document.createRange();
  range.selectNode(element);
  window.getSelection().removeAllRanges();
  window.getSelection().addRange(range);

  try {
    document.execCommand('copy');
    alert('Code copied to clipboard!');
  } catch (err) {
    console.error('Unable to copy code:', err);
  } finally {
    window.getSelection().removeAllRanges();
  }
}


const renderMarkdown = () => {
  const html = md.render(markdown.value);

  const parser = new DOMParser();
  const doc = parser.parseFromString(html, 'text/html');

  return doc.body.innerHTML;
}

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
  position: relative;
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

img {
  display: block;
}

.copyButton {
  position: absolute;
  top: 10px;
  right: 20px;
  background-color: #333333;
}
</style>
