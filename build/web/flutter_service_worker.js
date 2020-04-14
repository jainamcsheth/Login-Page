'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "18ce7c2d6ae0226e0d702f731aa3bb82",
"assets/assets/images/boy_login.png": "eb307a221d250a0fc12bbcb4e695a681",
"assets/assets/images/loading_transparent_green_fast_gif.gif": "b4d29153328d4a73e27430f75971a608",
"assets/assets/images/loading_transparent_grey_gif.gif": "d452daacda184e8b3463441c6943d9dd",
"assets/assets/images/loading_transparent_red_gif.gif": "55d905f7f81b9fec132ed2cf5cb4aca2",
"assets/assets/images/login_security.png": "7650b0079bc59a395badeccb27ce6888",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "ecf948e199879da9e534b5fe650e27e4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "cf5f35452dc930847740dc0bcca9d908",
"/": "cf5f35452dc930847740dc0bcca9d908",
"main.dart.js": "894f002162f564cf37592a8f306d0a91",
"manifest.json": "b6be3b7e5167e7cb18ffe2048cf9a152"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
