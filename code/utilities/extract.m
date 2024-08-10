%% Extracts a secret image from the given encoded image and message
function secret = extract(gim, mess)


    [m, n] = size(gim);
    secret = zeros(m, n/3, 3);
    L_rot = m * n / 8;
    start = 1;

    % Extract the rotation stream from the message
    rot_stream = mess(1:L_rot);
    start = start + L_rot;
    L_rot = L_rot / 2;

    % Reshape the rotation stream and convert to decimal
    rot = reshape(rot_stream, L_rot, 2);
    rot_vector = bi2de(rot);
    rot = reshape(rot_vector, 3, L_rot / 3);

    % Load the original rotation matrix for comparison
    ro = importdata('rot.mat');

    disp(sum(abs(rot(:) - ro(:))));
    save('rot.mat', 'rot');

    % Extract the number of bits required for place encoding
    num = m * n * 5 / 16;
    L_num = length(dec2bin(num));
    L_stream = mess(start:(start + L_num - 1));
    start = start + L_num;
    L_place = bi2de(L_stream);

    % Extract and decode the place stream
    place_stream = mess(start:(start + L_place - 1));
    start = start + L_place;
    % place_vector = dehuffman(place_stream'); 
    L_p = length(place_vector) / 3;
    place = reshape(place_vector, 3, L_p);

    % Load the original place matrix for comparison
    tag = importdata('tag.mat');
    % Calculate and display the difference between extracted and original place
    disp(sum(abs(place(:) - tag(:))));
    save('tag.mat', 'place');

    % Flow extraction process
    fl = importdata('flow.mat');
    num = m * n / 2;
    L_num = length(dec2bin(num));
    L_stream = mess(start:(start + L_num - 1));
    start = start + L_num;
    L_place = bi2de(L_stream);

    % Extract and decode the flow stream
    place_stream = mess(start:(start + L_place - 1));
    % flow = dehuffman(place_stream');  
    % Calculate and display the difference between extracted and original flow
    % disp(sum(abs(fl(:) - flow(:))));
    save('flow.mat', 'flow');

    % Threshold extraction process
    thh = importdata('th.mat');
    L_th = length(mess) - start + 1;
    th_stream = mess(start:end);

    % Decode the threshold stream
    th_vector = dehuffman(th_stream');  
    L_t = length(th_vector) / 3;
    th = reshape(th_vector, 3, L_t);

    % Calculate and display the difference between extracted and original threshold
    disp(sum(abs(thh(:) - th(:))));
    save('th.mat', 'th');

    % Recover the secret image for each color channel
    for i = 1:3
        secret(:,:,i) = recover(gim(:,:,i), rot(i,:), place(i,:), th(i,:));
    end
end
