import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double w(BuildContext context)=> MediaQuery.of(context).size.width;
double h(BuildContext context)=> MediaQuery.of(context).size.height;

InputDecoration decoration(String hint)=>InputDecoration(
  hintText: hint,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Change border color as needed
                      width: 2.0, // Adjust border width for desired thickness
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue, // Change focus border color
                      width: 2.0, // Adjust border width for desired thickness
                    ),
                  ),
                );