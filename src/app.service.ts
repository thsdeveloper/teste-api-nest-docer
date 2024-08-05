import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!. Google Deploy Dockerfile. Sucesso!';
  }
}
