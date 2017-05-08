/* 
================================================================================
檔案代號:imaw_t
檔案名稱:條碼資訊明細變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imaw_t
(
imawent       number(5)      ,/* 企業編號 */
imawsite       varchar2(10)      ,/* 營運據點 */
imawdocno       varchar2(20)      ,/* 調整單號 */
imawseq       number(10,0)      ,/* 項次 */
imaw000       number(5,0)      ,/* 版次 */
imaw001       varchar2(40)      ,/* 條碼編號 */
imaw002       varchar2(10)      ,/* 庫位 */
imaw003       varchar2(10)      ,/* 儲位 */
imaw004       varchar2(30)      ,/* 批號 */
imaw005       varchar2(30)      ,/* 製造批號 */
imaw006       varchar2(30)      ,/* 製造序號 */
imaw007       number(20,6)      ,/* 庫存數量 */
imawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imawud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imaw_t add constraint imaw_pk primary key (imawent,imawdocno,imawseq) enable validate;

create unique index imaw_pk on imaw_t (imawent,imawdocno,imawseq);

grant select on imaw_t to tiptop;
grant update on imaw_t to tiptop;
grant delete on imaw_t to tiptop;
grant insert on imaw_t to tiptop;

exit;
