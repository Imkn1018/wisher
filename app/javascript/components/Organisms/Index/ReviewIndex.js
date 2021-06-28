import {
  ChakraProvider,
  Stack,
  Box,
  Image,
  Text,
  Wrap,
  WrapItem,
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalCloseButton,
  ModalBody,
  useDisclosure,
  Button,
  ModalFooter,
  FormControl,
  FormLabel,
  Input,
} from '@chakra-ui/react';

import React from 'react';
import { useState } from 'react';
import axios from 'axios';

function ReviewIndex(props) {
  // props
  const { wish, completeReviews } = props;
  // 新規登録時のstate
  const [reviewTitle, setReviewTitle] = useState('');
  const [review, setReview] = useState('');
  const [imageUrl, setImgaeUrl] = useState('');
  // 初期値のstate
  const [reviews, setReviews] = useState(completeReviews);
  // 選択して表示する際のstate
  const [selectedReview, setSelectedReview] = useState([]);
  // 新しくreviewを追加する際のstate
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);

  const { isOpen, onClose, onOpen } = useDisclosure();

  const postReview = () => {
    axios.post(`/wishes/${wish.id}/complete_reviews`, {
      review_title: reviewTitle,
      review: review,
      complete_image: imageUrl,
    });

    const newReviews = [
      ...reviews,
      {
        id: reviews[0] ? reviews.slice(-1)[0].id + 1 : 1,
        wish_id: wish.id,
        review_title: reviewTitle,
        review: review,
        complete_image: imageUrl,
      },
    ];
    setReviews(newReviews);

    setReviewTitle('');
    setReview('');
    setImgaeUrl('');
    setIsCreateModalOpen(false);
    onClose();
  };

  const onOpenCreate = () => {
    setIsCreateModalOpen(true);
    console.log(isCreateModalOpen);
    onOpen();
  };
  const onCloseCreate = () => {
    setIsCreateModalOpen(false);
  };

  // review.idを基に該当のreviewを選択→モーダル表示
  const onClickSelectReview = (id) => {
    const targetReview = reviews.find((review) => review.id === id);

    // state更新
    setSelectedReview(targetReview);
    // モーダルオープン
    onOpen();
  };
  // 削除処理
  const deleteReview = () => {
    axios.delete(
      `/wishes/${wish.id}/complete_reviews/${selectedReview.id}`,
      selectedReview
    );
    const newReviews = [...reviews];
    console.log(selectedReview);
    // newReviews.filter((review) => review.id !== selectedReview.id);
    const updateReview = newReviews.filter(
      (rev) => rev.id !== selectedReview.id
    );
    console.log(updateReview);
    setReviews(updateReview);
    onClose();
  };

  return (
    <ChakraProvider>
     <Button onClick={onOpenCreate} >達成レビューを記録する</Button>
      <Wrap p={4} justify="center">
        {reviews &&
          reviews.map((review, id) => (
            <WrapItem key={id}>
              <Box
                w="300px"
                h="300px"
                bg="white"
                borderRadius="10px"
                shadow="md"
                p={4}
                _hover={{ cursor: 'pointer', opacity: 0.8 }}
                onClick={() => {
                  onClickSelectReview(review.id);
                }}
              >
                <Stack textAlign="center">
                  <Image
                    boxSize="160px"
                    borderRadius="full"
                    src={review.complete_image}
                    alt={review.review_title}
                    m="auto"
                  />
                  <Text fontSize="lg" fontWeight="bold">
                    {review.review_title}
                  </Text>
                  <Text fontSize="sm" color="gray">
                    {review.memo}
                  </Text>
                </Stack>
              </Box>
            </WrapItem>
          ))}
      </Wrap>

      {isCreateModalOpen === false && (
        <Modal
          isOpen={isOpen}
          onClose={onClose}
          autoFocus={false}
          motionPreset="scale"
          isCentered={true}
        >
          <ModalOverlay>
            <ModalContent pb={2}>
              <ModalHeader>Show</ModalHeader>
              <ModalCloseButton />
              <ModalBody mx={4}>
                <Stack textAlign="center">
                  <Image
                    boxSize="160px"
                    borderRadius="full"
                    src={selectedReview?.complete_image}
                    alt={selectedReview?.review_title}
                    m="auto"
                  />
                  <Text fontSize="lg" fontWeight="bold">
                    {selectedReview?.review_title}
                  </Text>
                  <Text fontSize="sm" color="gray">
                    {selectedReview?.review}
                  </Text>
                </Stack>
              </ModalBody>
              <ModalFooter>
                <Button onClick={deleteReview}>
                  delete
                </Button>
              </ModalFooter>
            </ModalContent>
          </ModalOverlay>
        </Modal>
      )}

      {isCreateModalOpen && (
        <Modal
          isOpen={isOpen}
          onClose={onClose}
          autoFocus={false}
          motionPreset="scale"
          isCentered={true}
          p={4}
        >
          <ModalOverlay>
            <ModalContent  p={5} py="auto">
              <ModalCloseButton
                onClick={() => {
                  setReviewTitle('');
                  setReview('');
                  setImgaeUrl('');
                  onCloseCreate();
                }}
              />
               <Text fontSize="lg" fontWeight="bold" p={3}>新しくレビューを記録する</Text>
              <ModalBody mx={4}>
                <Stack spacing={4}>
                  <FormControl>
                    <FormLabel>レビュータイトル（必須）</FormLabel>
                    <Input
                      value={reviewTitle}
                      onChange={(e) => setReviewTitle(e.target.value)}
                    />
                  </FormControl>
                  <FormControl>
                    <FormLabel>レビュー本文</FormLabel>
                    <Input
                      value={review}
                      onChange={(e) => setReview(e.target.value)}
                    />
                  </FormControl>
                  <FormControl>
                    <FormLabel>画像</FormLabel>
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
                  {imageUrl && <Image src={imageUrl} boxSize="160px" />}
                </Stack>
              </ModalBody>

              <ModalFooter>
                {reviewTitle ? (
                  <Button onClick={postReview}>達成レビューを記録する</Button>
                ) : (
                  <Text>タイトルは必須項目となります</Text>
                )}
              </ModalFooter>
            </ModalContent>
          </ModalOverlay>
        </Modal>
      )}
    </ChakraProvider>
  );
}

export default ReviewIndex;
