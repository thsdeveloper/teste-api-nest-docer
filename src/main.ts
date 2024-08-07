import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module';

async function bootstrap() {
  try {
    const app = await NestFactory.create<NestExpressApplication>(AppModule);
    await app.listen(process.env.PORT || 8080);
    console.log(`Application is running on: ${await app.getUrl()}`);
  } catch (error) {
    console.error('Error starting the server:', error);
    process.exit(1); // Optional: exit the process with a non-zero status code
  }
}
bootstrap();
