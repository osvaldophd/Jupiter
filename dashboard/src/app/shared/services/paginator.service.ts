import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class PaginatorService {

  pageNumber: number = 1;
  pages: Array<number>;
  Data: Array<any> = [];
  Result: Array<any>;
  pageSize: number = 8;


  constructor() { }

  setData(Data) {
    this.Data = Data;
  }

  setPageSize(page) {
    this.pageSize = page;
  }

  setPage(page) {
    this.pageNumber = page;
  }

  setAllData(Data: Array<any>, page_size: number, pageNumber: number) {
    this.Data = Data;
    this.pageSize = page_size;
    this.pageNumber = pageNumber;
    this.paginate();

  }

  getData() {
    this.paginate();
    return this.Result;
  }

  getPages() {
    return this.pages;
  }

  getPaginator(Data: Array<any>) {
    this.Data = Data 
    this.paginate();
    return this.Result;
  }



  private paginate() {

    const pageSize = this.pageSize;
    var pageNumber: number = this.pageNumber;
    const Data: Array<any> = this.Data;
    var pages: Array<any> = [];

    let total_page = Math.ceil(Data.length / pageSize);
    total_page = (total_page === 1)? 0 : total_page; 

    for (let i = 1; i <= total_page; i++) { pages.push(i) }
    if (pageNumber > total_page || pageNumber < 0) { pageNumber = 1 }

    this.pages = pages;
    this.Result = Data.slice((pageNumber - 1) * pageSize, pageNumber * pageSize);

  }



}
