import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';

// V -> P(전역프로바이더, 뷰모델) -> R
class PostRepository {
  Future<ResponseDTO> fetchPostList(String jwt) async {
    try {
      // 1. 통신
      final response = await dio.get(
        "/post",
        options: Options(headers: {"Authorization": "${jwt}"}),
      );

      // 2. Response 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 3. ResponeDTO의 data파싱
      List<dynamic> mapList = responseDTO.data as List<dynamic>;
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();

      // 4. 파싱된 데이터를 다시 공통 DTO로 덮어씌우기
      responseDTO.data = postList;

      // responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      // 상태코드 200 이 아니면 catch로 간다
      return ResponseDTO(-1, "중복되는 유저명입니다", null);
    }
  }
}
