# Yeti Project

Small stealth game about a Yeti

## Run project

1 - Start comp server
```sh
npm run comp-server
```

2 - Start project
```sh
npm start
```
3 - After changing a file HARD REFRESH browser to see the update

## Bump version
```sh
npm run release -- --release-as patch
npm run release -- --release-as minor
npm run release -- --release-as major
```

```sh
git push --follow-tags origin main
```

## Controls
- LEFT/RIGHT/A/D - move
- SHIFT - throw snowball
- UP/W - action button