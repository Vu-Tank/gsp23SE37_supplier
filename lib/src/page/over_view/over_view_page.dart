import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:url_launcher/url_launcher.dart';

class OverViewPage extends StatefulWidget {
  const OverViewPage({super.key});

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          }),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Kết nối với chúng tôi',
                      style: AppStyle.h2,
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.facebook)),
                    IconButton(
                        onPressed: () async {
                          String email =
                              Uri.encodeComponent("esmpOffice@gmail.com");
                          String subject = Uri.encodeComponent("Xin Chào");
                          String body = Uri.encodeComponent(
                              "Xin Chào"); //output: Hello%20Flutter
                          Uri mail = Uri.parse(
                              "mailto:$email?subject=$subject&body=$body");
                          if (await launchUrl(mail)) {
                            //email app opened
                          } else {
                            //email app is not opened
                          }
                        },
                        icon: const Icon(Icons.email)),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '1. Giới thiệu',
                  style: AppStyle.h1,
                ),
                Text(
                  '1.1 Bạn cam kết rằng:',
                  style: AppStyle.h2,
                ),
                Text(
                  '(a) bạn là người thành niên và bạn có đủ khả năng và năng lực để tham gia vào Điều Khoản này; hoặc\n(b) bạn là cha mẹ hoặc người giám hộ hợp pháp của người dùng đang sử dụng Nền Tảng Lazada và đồng ý chấp thuận Điều Khoản này và đảm bảo rằng người dùng đó cũng chịu sự ràng buộc và tuân thủ Điều khoản này.',
                  style: AppStyle.h2,
                ),
                Text(
                  '1.2 Trong trường hợp bạn là người chưa thành niên, bạn cần phải có sự chấp thuận của bố (mẹ) hoặc người giám hộ hợp pháp để mở tài khoản trên Nền Tảng Lazada. Nếu bạn là bố mẹ hoặc người giám hộ hợp pháp của người vị thanh niên, bạn cần đồng ý và tuân thủ Điều Khoản này với tư cách là người đại điện của người chưa thành niên đó và phải chịu trách nhiệm với bất kỳ chi phí phát sinh nào có liên quan đến việc sử dụng Nền Tảng Lazada hoặc việc sử dụng Dịch Vụ của người chưa thành niên đó. Nếu bạn không được đồng ý của cha mẹ hoặc người giám hộ hợp pháp, bạn phải ngừng việc sử dụng / truy cập vào Nền Tảng Lazada và / hoặc Dịch Vụ.',
                  style: AppStyle.h2,
                ),
                Text(
                  '2. Nội Dung Bị Cấm',
                  style: AppStyle.h1,
                ),
                Text(
                  '2.1 Bạn đồng ý không tải lên hoặc bằng cách khác làm cho hiển thị bất kỳ Nội Dung Bị Cấm nào.',
                  style: AppStyle.h2,
                ),
                Text(
                  '2.2 Không ảnh hưởng đến các điều khoản nêu trên, bạn đồng ý tuân thủ các hạn chế như sau:',
                  style: AppStyle.h2,
                ),
                Text(
                  '(a) Không cho phép nội dung phản cảm, ví dụ như như nội dung mang tính chất phỉ báng, nội dung liên quan đến bạo lực, tàn nhẫn, khỏa thân, tình dục, lệch lạc giới tính, khiêu dâm, xúc phạm giới tính, chèo kéo mại dâm, sử dụng ngôn từ phản cảm, dẫn chứng thô tục, phát biểu mang tính thù địch; hoặc nội dung khiếm nhã, gây ám ảnh, giả dối, bất kể có ác ý hay cố tình làm phiền, lạm dụng, đe dọa hoặc quấy rối người khác hay không.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(b) Không cho phép nội dung không phù hợp với người dùng từ 18 tuổi trở xuống.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(c) Không cho phép nội dung kích động khủng bố hoặc các hành động liên quan đến khủng bố.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(d) Không cho phép nội dung chứa các dẫn chiếu đến các khuyết tật về thể chất, tinh thần hoặc giác quan.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(e) Không cho phép nội dung khuyến khích công chúng tham gia vào hoặc cổ vũ các hành vi trái pháp luật, bạo lực, bán hoặc tiêu thụ ma túy, thuốc hướng thần hoặc các chất gây nghiện khác.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(f) Không cho phép nội dung kích động, lật đổ, bạo động, chẳng hạn như nội dung kích động hoặc cổ vũ xung đột chống lại một quốc gia hay bất cứ nhà nước nào, cũng như hiến pháp, chính phủ hoặc luật pháp của quốc gia đó. hoặc kích động hoặc cổ vũ xung đột giữa các cộng đồng, dân tộc, sắc tộc, tôn giáo hoặc giới tính, hoặc gây suy giảm niềm tin tôn giáo hoặc văn hóa.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(g) Không cho phép nội dung liên quan đến cờ bạc như bài bạc, xổ số, đua ngựa, cá cược thể thao, chiêm tinh, bói đất, bói chỉ tay hoặc bất kỳ hình thức bói toán nào khác.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(h) Không cho phép nội dung liên quan đến người chưa thành niên mà không có sự đồng ý bằng văn bản của cha mẹ hoặc người giám hộ hợp pháp của người chưa thành niên đó.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(i) Không cho phép nội dung liên quan đến hoặc quảng bá cho các nội dung/sản phẩm/dịch vụ bị cấm hoặc bị hạn chế theo bất kỳ quy định pháp luật nào.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(j) Không cho phép hành vi xâm phạm đến quyền sở hữu trí tuệ hoặc gây nhầm lẫn về mối quan hệ với các tổ chức hoặc cá nhân khác.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(k) Không cho phép nội dung có liên quan đến việc mạo danh tổ chức, cá nhân khác trừ khi có sự cho phép bằng văn bản của cá nhân, tổ chức đó.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(l) Không cho phép nội dung quảng bá cho các thông điệp chính trị.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(m) Không cho phép nội dung vi phạm quy định pháp luật về bảo vệ dữ liệu và quyền sở hữu trí tuệ.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(n) Không cho phép nội dung gây hiểu lầm, sai lệch hoặc lừa đảo (ví dụ, nội dung gây hiểu lầm về giá của sản phẩm được bán và nội dung chứa các tuyên bố sai sự thật rằng hàng hóa là có giới hạn hoặc sẽ đi kèm với quà tặng miễn phí).',
                  style: AppStyle.h2,
                ),
                Text(
                  '(o) Không cho phép nội dung chứa các từ giống như, hoặc có ý nghĩa tương tự như, “nhất”, “tốt nhất”, “số một”, “đã được chứng minh”, “hàng đầu”.',
                  style: AppStyle.h2,
                ),
                Text(
                  '(p) Không cho phép nội dung thể hiện sự so sánh trực tiếp về giá, chất lượng, hiệu quả của sản phẩm của bạn với các sản phẩm khác (dành cho Nhà Bán Hàng).',
                  style: AppStyle.h2,
                ),
                Text(
                  '(q) Không cho phép nội dung là thư rác, lừa đảo hoặc lừa dối.',
                  style: AppStyle.h2,
                ),
                Text(
                  '3 Chính sách về vi phạm đăng bán sản phẩm',
                  style: AppStyle.h1,
                ),
                Text(
                  '3.1 Tại sao sản phẩm bị khóa trên ESMP',
                  style: AppStyle.h2,
                ),
                Text(
                  'Sản phẩm của Shop sẽ bị khóa, không cần phải báo trước nếu như vi phạm một trong những lý do: ',
                  style: AppStyle.h2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Một ID đăng quá nhiều thông tin của các sản phẩm khác nhau',
                        style: AppStyle.h2,
                      ),
                      Text(
                        'Sản phẩm chứa thông tin liên kết đến website khác',
                        style: AppStyle.h2,
                      ),
                      Text(
                        'Thông tin sản phẩm có dấu hiệu gian lận',
                        style: AppStyle.h2,
                      ),
                      Text(
                        'Shop bán sản phẩm bị cấm theo quy định pháp luật.',
                        style: AppStyle.h2,
                      ),
                    ],
                  ),
                ),
                Text(
                  '3.2 Mẹo để tránh sản phẩm bị khóa trên ESMP',
                  style: AppStyle.h2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hình ảnh sản phẩm đúng chuẩn khi đăng bán là không chứa logo của các thương hiệu lớn',
                        style: AppStyle.h2,
                      ),
                      Text(
                        'Tiêu đề sản phẩm tránh đặt những từ gây hiểu lầm hoặc không đúng sự thật như: Freeship (nhưng lại không được Freeship), Rẻ vô địch,…',
                        style: AppStyle.h2,
                      ),
                      Text(
                        'Sử dụng hình ảnh chân thật về sản phẩm',
                        style: AppStyle.h2,
                      ),
                      Text(
                        'Viết mô tả thật đúng, đủ và chi tiết về sản phẩm',
                        style: AppStyle.h2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
