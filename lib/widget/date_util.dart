String timeAgo(DateTime date) {
  DateTime today = DateTime.now();
  Duration oneDay = const Duration(days: 1);
  Duration twoDay = const Duration(days: 2);
  Duration oneWeek = const Duration(days: 7);
  late String month;
  switch (date.month) {
    case 1:
      month = "Jan";
      break;
    case 2:
      month = "Feb";
      break;
    case 3:
      month = "Maret";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "Mei";
      break;
    case 6:
      month = "Juni";
      break;
    case 7:
      month = "Juli";
      break;
    case 8:
      month = "Agus";
      break;
    case 9:
      month = "Sept";
      break;
    case 10:
      month = "Okt";
      break;
    case 11:
      month = "Nov";
      break;
    case 12:
      month = "Des";
      break;
  }

  Duration difference = today.difference(date);
  if (difference.inSeconds < 60) {
    return "Baru saja";
  } else if (difference.inMinutes < 60) {
    return difference.inMinutes.toString() + " Menit yang lalu";
  } else if (difference.inHours < 6) {
    return difference.inHours.toString() + " Jam yang lalu";
  } else if (difference.compareTo(oneDay) < 1) {
    return "Hari Ini";
  } else if (difference.compareTo(twoDay) < 1) {
    return "Kemarin";
  } else if (difference.compareTo(oneWeek) < 1) {
    switch (date.weekday) {
      case 1:
        return "Senin Kemarin";
      case 2:
        return "Selasa Kemarin";
      case 3:
        return "Rabu Kemarin";
      case 4:
        return "Kamis Kemarin";
      case 5:
        return "Jum'at Kemarin";
      case 6:
        return "Sabtu Kemarin";
      case 7:
        return "Minggu Kemarin";
    }
  } else if (date.year == today.year) {
    return '${date.day} $month ${date.year}';
  } else {
    return '${date.day} $month ${date.year}';
  }
  return date.toString();
}

String kelompok(int batch) {
  if (batch == 0) {
    return 'Semua Kelompok';
  } else {
    return 'Kelompok $batch';
  }
}
