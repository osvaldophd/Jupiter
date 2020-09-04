import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ShareContaService {

  constructor() { }

  actualiza : BehaviorSubject<boolean> = new BehaviorSubject(false);
}
