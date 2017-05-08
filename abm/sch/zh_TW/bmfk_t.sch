/* 
================================================================================
檔案代號:bmfk_t
檔案名稱:ECN特對應單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfk_t
(
bmfkent       number(5)      ,/* 企業編號 */
bmfksite       varchar2(10)      ,/* 營運據點 */
bmfkdocno       varchar2(20)      ,/* ECN單號 */
bmfk002       number(10,0)      ,/* ECN項次 */
bmfk003       varchar2(30)      ,/* 特徵代碼 */
bmfk004       varchar2(10)      ,/* 對應方式 */
bmfkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfk_t add constraint bmfk_pk primary key (bmfkent,bmfksite,bmfkdocno,bmfk002,bmfk003) enable validate;

create unique index bmfk_pk on bmfk_t (bmfkent,bmfksite,bmfkdocno,bmfk002,bmfk003);

grant select on bmfk_t to tiptop;
grant update on bmfk_t to tiptop;
grant delete on bmfk_t to tiptop;
grant insert on bmfk_t to tiptop;

exit;
