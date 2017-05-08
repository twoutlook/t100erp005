/* 
================================================================================
檔案代號:imbl_t
檔案名稱:料件申請料號標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imbl_t
(
imblent       number(5)      ,/* 企業編號 */
imbldocno       varchar2(20)      ,/* 申請單號 */
imbl001       varchar2(40)      ,/* 料件編號 */
imbl002       varchar2(10)      ,/* 產品標籤 */
imblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imblud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbl_t add constraint imbl_pk primary key (imblent,imbldocno,imbl002) enable validate;

create  index imbl_01 on imbl_t (imbl001);
create unique index imbl_pk on imbl_t (imblent,imbldocno,imbl002);

grant select on imbl_t to tiptop;
grant update on imbl_t to tiptop;
grant delete on imbl_t to tiptop;
grant insert on imbl_t to tiptop;

exit;
