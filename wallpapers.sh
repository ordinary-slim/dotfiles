urls=(
"https://runescape.wiki/images/Nomad%27s_Elegy_wallpaper.jpg?9a15c"
"https://runescape.wiki/images/Kindred_Spirits_wallpaper.jpg?6611d"
"https://runescape.wiki/images/Dagannoth_Kings_Rework_wallpaper.jpg?443d8"
"https://runescape.wiki/images/Horror_Animations_wallpaper.jpg?b40a1"
"https://runescape.wiki/images/Knight_wallpaper.jpg?4716f"
"https://runescape.wiki/images/Thumb_Before_the_Fall.jpg?8cec9"
"https://runescape.wiki/images/Thumb_Fremennik_Warrior.jpg?db4c4"
"https://runescape.wiki/images/Thumb_Castle_Wars.jpg?cd767"
"https://runescape.wiki/images/The_Grotworm_Lair_wallpaper.jpg?3f61e"
"https://runescape.wiki/images/Ghast_wallpaper.jpg?b8ab3"
"https://runescape.wiki/images/Ariane_wallpaper.jpg?df9d1"
"https://runescape.wiki/images/Dungeoneering_Demon_wallpaper.jpg?9e073"
"https://runescape.wiki/images/Thumb_Balance_Elemental.jpg?46d8a"
"https://runescape.wiki/images/Thumb_Tormented_demon.jpg?b618d"
"https://runescape.wiki/images/Jad_1920x1200.jpg?8cd60"
"https://runescape.wiki/images/Thumb_K%27ril_Tsutsaroth.jpg?20521"
"https://runescape.wiki/images/Clan_Citadel_Senate_wallpaper.jpg?206ab"
"https://runescape.wiki/images/Til_Death_Do_Us_Part_-_Death_wallpaper.jpg?47fff"
"https://runescape.wiki/images/Thumb_Corporeal_Best.jpg?02c40"
"https://runescape.wiki/images/Giant_Mole_wallpaper.jpg?4716f"
"https://runescape.wiki/images/Barrows_Brothers_wallpaper.jpg?3c292"
)
for url in ${urls[@]}; do
  fname=$(basename $url)
  fname="${fname%%.jpg*}.jpg"
  fname="${fname//%27/}"
  fname="${fname// /_}"
  referer=${url//images\//w\/File:}
  wget --user-agent='Mozilla' \
    --referer=${referer} \
    -O ${fname} "$url"
done
