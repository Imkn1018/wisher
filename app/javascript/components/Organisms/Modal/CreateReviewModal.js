import {
  ChakraProvider,
  Stack,
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalCloseButton,
  ModalBody,
  FormControl,
  FormLabel,
  Input,
  Button,
  Image,
  ModalFooter,
  useDisclosure,
} from '@chakra-ui/react';
import React from 'react';
import { memo, VFC, useState, useEffect, ChangeEvent } from 'react';
import axios from 'axios';

function NewReviewModal() {
  const { isOpen, onClose, onOpen } = useDisclosure();
  const [wishTitle, setWishTitle] = useState('');
  const [memo, setMemo] = useState('');
  const [imageUrl, setImgaeUrl] = useState('');
  const [tag, setTag] = useState('');

  const postWish = (params) => {
    axios.post('/wishes', {
      wish_title: wishTitle,
      memo: memo,
      tag_name: tag,
      wish_image_id: imageUrl,
    });
    axios.post('/tags', {
      tag_name: tag,
    });
    axios.post('/wish_tag_relationships', {
      wish_id: params.wish_id,
      tag_id: params.tag_id,
    });
    setWishTitle('');
    setMemo('');
    setTag('');
    onClose();
  };
  return (
    <ChakraProvider>
      <Button onClick={onOpen}>OpenButton</Button>
      <Modal
        isOpen={isOpen}
        onClose={onClose}
        autoFocus={false}
        motionPreset="scale"
      >
        <ModalOverlay>
          <ModalContent pb={2}>
            <ModalHeader>Show</ModalHeader>
            <ModalCloseButton
              onClick={() => {
                setWishTitle('');
                setMemo('');
                setImgaeUrl('');
              }}
            />
            <ModalBody mx={4}>
              <Stack spacing={4}>
                <FormControl>
                  <FormLabel>Name</FormLabel>
                  <Input
                    value={wishTitle}
                    onChange={(e) => setWishTitle(e.target.value)}
                  />
                </FormControl>
                <FormControl>
                  <FormLabel>memo</FormLabel>
                  <Input
                    value={memo}
                    onChange={(e) => setMemo(e.target.value)}
                  />
                </FormControl>
                <FormControl>
                  <FormLabel>tag</FormLabel>
                  <Input value={tag} onChange={(e) => setTag(e.target.value)} />
                </FormControl>

                <FormControl>
                  <FormLabel>Image</FormLabel>
                  <Input
                    type="file"
                    accept="image/*"
                    onChange={(e) => {
                      const imageFile = e.target.files[0];
                      const imageUrl = URL.createObjectURL(imageFile);
                      setImgaeUrl(imageUrl);
                    }}
                  />
                </FormControl>
                {imageUrl && <Image src={imageUrl} />}
              </Stack>
            </ModalBody>
            <ModalFooter>
              <Button onClick={postWish}></Button>
            </ModalFooter>
          </ModalContent>
        </ModalOverlay>
      </Modal>
    </ChakraProvider>
  );
}

export default NewReviewModal;
