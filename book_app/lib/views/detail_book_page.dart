import 'dart:convert';

import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/models/book_detail_response.dart';
import 'package:book_app/models/book_list_response.dart';
import 'package:book_app/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key, required this.isbn});

  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return controller.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageScreenView(
                                    imageUrl: controller.detailBook!.image!),
                              ),
                            );
                          },
                          child: Image.network(
                            controller.detailBook!.image!,
                            height: 150,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.detailBook!.title!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.authors!,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: List.generate(
                                      5,
                                      (index) => Icon(
                                            Icons.star,
                                            color: index <
                                                    int.parse(controller
                                                        .detailBook!.rating!)
                                                ? Colors.yellow
                                                : Colors.grey,
                                          )),
                                ),
                                Text(
                                  controller.detailBook!.subtitle!,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.price!,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            ("url");
                            Uri uri = Uri.parse(controller.detailBook!.url!);
                            try {
                              (await canLaunchUrl(uri))
                                  ? launchUrl(uri)
                                  : ("tidak berhasil Navigasi");
                            } catch (e) {
                              ("error");
                              (e);
                            }
                          },
                          child: const Text("Beli")),
                    ),
                    const SizedBox(height: 20),
                    Text(controller.detailBook!.desc!),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Year: ${controller.detailBook!.year!}"),
                        Text("ISBN: ${controller.detailBook!.isbn13!}"),
                        Text("${controller.detailBook!.pages!} Pages"),
                        Text("Publisher: ${controller.detailBook!.publisher!}"),
                        Text("Language: ${controller.detailBook!.language!}"),
                        Text(controller.detailBook!.rating!),
                      ],
                    ),
                    const Divider(),
                    controller.similiarBooks == null
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: SizedBox(
                              height: 180,
                              child: ListView.builder(
                                //shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.similiarBooks!.books!.length,
                                //physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final current =
                                      controller.similiarBooks!.books![index];
                                  return SizedBox(
                                    width: 80,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          current.image!,
                                          height: 80,
                                        ),
                                        Text(
                                          current.title!,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                  ],
                ),
              );
      }),
    );
  }
}
