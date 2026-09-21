'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"README.md": "eba6245fde6faa4d4be8a650235fee72",
"manifest.json": "1fe0033187b31a7baffe5665bac09fb6",
"assets/fonts/MaterialIcons-Regular.otf": "51860f1a7cd3f0c722de07c8e8f9c8d8",
"assets/AssetManifest.json": "5e0b94e812e393e4553d3c97d3058335",
"assets/NOTICES": "2b24134e720bc8bb35cad336197ea3c9",
"assets/assets/whatsapp.png": "82e5b748febb65bb88a4b3179626ff5e",
"assets/AssetManifest.bin": "428334e7cf52e2c69449c33a0dca3b56",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "ed2b465c0bc156df831172ca8b0512c5",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"flutter_bootstrap.js": "ba0d1dd2d164241e8d3fb80051360b85",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/62/c89ee094658c7a9465824fdb42793a64ea557b": "133cd5da638f245b079d9e9cdc29ae38",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/8a270055b1d131ebeb1c2e1955c0ecb5696fa4": "d245c88138ca632b96d383065e376902",
".git/objects/db/853cb909689b92ed91db8c4ab23281bc51e806": "152220102f7a51bcce94eed65507f3ef",
".git/objects/97/eaafe6e96a163aeda97373d5860c857c44f302": "7ebe5a7b32ac2979df615a73dfc5ea8e",
".git/objects/16/653658291e42ff8add8444406a47593103fd8c": "290482fdabdb8f753ab21aeaa57bf2e6",
".git/objects/16/29513c0f20554428e3dbb6a617b157fad0d060": "88224d50201f24eca90e7180eca7483d",
".git/objects/8f/368292a70675725b4d450fb31a7af7e7a2465c": "f772b016eabfd2336c517d3cfb18602d",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/c2/8304297e6d3e00530db1e7dc45caf6065f1989": "9388416de9e2efe1cde34db38dcad037",
".git/objects/36/25c02d558545ac807be3c4b71b68c407158852": "27e94f3dce4a93d7e1899da41145a4e1",
".git/objects/d0/44336f49d850d67b517d6b23a31ae49ab37062": "1911ce73d0f08fc8be9bc8d9f9411d19",
".git/objects/7c/e5ed9f1d3879c930ae7111e4ea806607b47e43": "aa8fabc7509df0365c9ece9107e56388",
".git/objects/f6/8b92d871c1e247832e146230b3f3bc7c9710d3": "25a3556e5a4faa79373277d12db7a4e1",
".git/objects/da/354fab465c9c98b51fff3f552a6017ce98dd54": "7541f06ed378730a6939e7b75b98f0f0",
".git/objects/da/db20e128c2fa58959577d726db6ed060e651e2": "8ad8ade7fca05f906b4f6394d09db7d2",
".git/objects/70/6895de234420d54d09dd35a4178751ed269962": "71c4372826ebabec4b848186ba875667",
".git/objects/9b/9d0962299276d7bb73d0c475bdb1c1fab50902": "39a7321ec91763dc97473d64fb67e65c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/1b/e23606a1b9c17135db68477621ad7fe5c99174": "c40ac96fa7918bdc99de6ec2694eb672",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/8c/fad4a9b640806a870653377f05db8163f63a57": "9f0c127bcbde9f75dca4717253993a9c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/9e/26dfeeb6e641a33dae4961196235bdb965b21b": "304148c109fef2979ed83fbc7cd0b006",
".git/objects/0f/c344c7e8b9e32ea1ad91f30ded22556352d7bf": "a8a30f28869f7378465338066f34d80d",
".git/objects/0e/6fed4a62b03f4d5e88f3f4245f04fe955e47b3": "65d4925ee863a9240c6c628eeb835159",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/aa/7d28940a17abe222409f67f15d366896cb1309": "545ccf79eb118fbf1422302521db1add",
".git/objects/cb/eb44fab21e03c630b45e5a6dd15ab2f0b9d139": "57f1a7c97969d6dae238404fd7071f17",
".git/objects/86/d111f09a93cccfa0011858c519a823e7dafef7": "9a15839a59b5f501fbf7b9824c4b6f84",
".git/objects/9c/dffa1a03c5a9156a4310225ef5cd1d97371e3d": "86cdb9010693252a4f6af327d2087d3f",
".git/objects/9c/77cd98de7b1b12b3218a16134b60c1e445517a": "9eaf616eb7d5b116e6378942b9aca13a",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/27/ef024d120bfdfd223b9f9ded7571d8afc719b8": "46d3b614ba0d7d18b82b924a754304bc",
".git/objects/c3/6ac5c0cca526f31087d3ce2def56eeed5a5585": "1dac8125aa9ed4038b0d3e43be24b117",
".git/objects/f3/db892777ad8493dc015825a5cfe542121e5133": "10a84478c65415db2dd93ee06db0b41f",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/20/e042b6b2e477e30a8d802af85c8cef3c687e0f": "b2da6d1a7a3700d1f95f39fabcfba2ea",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/50/5ae0560c469e1f3580fd5c377268e9061dde23": "c8ab3896172943230358926c3a755183",
".git/objects/b4/b23deb529ddf027dd1a7f48096b60962b038b7": "33e72cf5264b8d9a0691d699e608f003",
".git/objects/bd/ac5912779eceb1729187de1cde50dc1c079b28": "c0127c35eb946ea4dc737c81ede5bb0a",
".git/objects/b9/8328053858f7945958cd93ea4de7e2d0e3d2e0": "d4391f9f633ea70bf62be8df72efab3f",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/64/54c8d4c538d05fe93c181a896aebc39c40e9f9": "60d079e331888f87cb1926aee2c049ba",
".git/objects/5e/694d9aeb2999cb9a79f5b45b9f7bec1884ca8f": "01e1ef42a0232c788a78b4fabf56273e",
".git/objects/10/7f2ce7af060aa01f76cd5048a102779277fb0b": "40ebf5b9db8d8a1aae88b2d8f65cf994",
".git/objects/f4/8ea22f08985922988fb94c3cb5bff1ea95a4ed": "fdf5295583c55bc9641cda286630380b",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/7b/6ed48b1da1d5371f7804bb2dcb37a1e42bdca1": "5fbb21909678d453c120abc992dad035",
".git/objects/81/dfa793a75f02b91f82ec77b81ade42a44752c7": "ce0e65ad72056a318ca04f02ddb8685b",
".git/objects/81/18732d596ab6a5396e5667a3647911eb5f5fc5": "c1942e0007d0ae4a4dcfeead01d7046c",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/refs/heads/master": "3ce1b6b62016531199cfd68ab38d8d37",
".git/config": "5b603c2c0801a9ded3b79159fc38b404",
".git/COMMIT_EDITMSG": "67fd0fd694858013767e06cce97c5f89",
".git/logs/HEAD": "5d084ad0e4e34b072163e968af90f4fc",
".git/logs/refs/heads/master": "5d084ad0e4e34b072163e968af90f4fc",
".git/index": "8e30388c3e91239b6340a06a4af5ad9f",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"version.json": "c743484dadc77c32eb71b17260918bdd",
"WIKI.md": "dfe40937eec20e0aa23642b507a4c12a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "86310165f2b98354460f856d39427943",
"/": "86310165f2b98354460f856d39427943",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"main.dart.js": "c06a6aa2243602fb7d640ea78871ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
