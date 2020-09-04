import {
  Injectable
} from '@angular/core';
import { Mask } from './../models/mask.model';

@Injectable()

export class MaskService {

  mask = {
    matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
    telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
    bi: [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/]
  };

  constructor() {}

  getMask = () => {
      return this.mask;
  }


}
