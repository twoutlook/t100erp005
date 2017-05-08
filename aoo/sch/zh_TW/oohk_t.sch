/* 
================================================================================
檔案代號:oohk_t
檔案名稱:控制組營運據點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohk_t
(
oohkent       number(5)      ,/* 企業編號 */
oohk001       varchar2(10)      ,/* 控制組編號 */
oohk002       varchar2(10)      ,/* 營運據點 */
oohk003       date      ,/* 生效日期 */
oohk004       date      ,/* 失效日期 */
oohkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohk_t add constraint oohk_pk primary key (oohkent,oohk001,oohk002) enable validate;

create  index oohk_01 on oohk_t (oohk003);
create  index oohk_02 on oohk_t (oohk004);
create unique index oohk_pk on oohk_t (oohkent,oohk001,oohk002);

grant select on oohk_t to tiptop;
grant update on oohk_t to tiptop;
grant delete on oohk_t to tiptop;
grant insert on oohk_t to tiptop;

exit;
