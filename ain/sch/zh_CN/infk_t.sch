/* 
================================================================================
檔案代號:infk_t
檔案名稱:貨架庫存表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infk_t
(
infkent       number(5)      ,/* 企業編號 */
infksite       varchar2(10)      ,/* 營運據點 */
infk001       varchar2(40)      ,/* 商品編號 */
infk002       varchar2(256)      ,/* 商品特征 */
infk003       varchar2(10)      ,/* 貨架編號 */
infk004       varchar2(10)      ,/* 庫存單位 */
infk005       number(20,6)      ,/* 數量 */
infk006       date      ,/* 最近異動日期 */
infkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infk_t add constraint infk_pk primary key (infkent,infksite,infk001,infk002,infk003) enable validate;

create unique index infk_pk on infk_t (infkent,infksite,infk001,infk002,infk003);

grant select on infk_t to tiptop;
grant update on infk_t to tiptop;
grant delete on infk_t to tiptop;
grant insert on infk_t to tiptop;

exit;
