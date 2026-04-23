import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
        plugins: [sveltekit()],
        css: {
                preprocessorOptions: {
                        scss: {
                                additionalData: `@import '${path.resolve('./src/styles/variables.scss')}';`
                        }
                }
        },
        server: {
                fs: {
                        allow: ['..']
                }
        }
});
