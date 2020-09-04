import { Component, OnInit } from '@angular/core';
import { VansService } from '../../services/vans.service';
import { ListVans } from '../../models/listVans.model';
import { environment } from 'src/environments/environment';

import { Pipe, PipeTransform } from '@angular/core';
import { ResponseVans } from '../../models/vans';
import { Van } from '../../../vans/models/vans';
import { Subscription } from 'rxjs/internal/Subscription';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})


export class ListComponent implements OnInit {

  // tslint:disable-next-line: variable-name
  api_path = environment.API_PATH;
  van: Van[];
  arraySubscription: Array<Subscription> = new Array<Subscription>();
  loading: boolean = true;

  constructor(private vansservice: VansService) { 

    // this.api_path = this.api_path+"images/vans/";

  }

  ngOnInit() {
    const vansSubscriptions = this.vansservice.getAll().pipe(
      finalize(()=> {
        this.loading = false;
      })
    ).subscribe( (res : ResponseVans ) => {
      this.van = res.data.vans
    });
    this.arraySubscription = [...this.arraySubscription, vansSubscriptions];
  }

}
