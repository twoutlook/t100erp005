/* 
================================================================================
檔案代號:imbk_t
檔案名稱:料件申請料號特徵檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imbk_t
(
imbkent       number(5)      ,/* 企業編號 */
imbk001       varchar2(40)      ,/* 料件編號 */
imbk002       varchar2(10)      ,/* 特徵類型 */
imbk003       varchar2(30)      ,/* 特徵值 */
imbkdocno       varchar2(20)      ,/* 申請編號 */
imbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbk_t add constraint imbk_pk primary key (imbkent,imbk002,imbkdocno) enable validate;

create  index imbk_01 on imbk_t (imbk001);
create unique index imbk_pk on imbk_t (imbkent,imbk002,imbkdocno);

grant select on imbk_t to tiptop;
grant update on imbk_t to tiptop;
grant delete on imbk_t to tiptop;
grant insert on imbk_t to tiptop;

exit;
