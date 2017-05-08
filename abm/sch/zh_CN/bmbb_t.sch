/* 
================================================================================
檔案代號:bmbb_t
檔案名稱:產品結構損耗率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmbb_t
(
bmbbent       number(5)      ,/* 企業編號 */
bmbbsite       varchar2(10)      ,/* 營運據點 */
bmbb001       varchar2(40)      ,/* 主件料號 */
bmbb002       varchar2(30)      ,/* 特性 */
bmbb003       varchar2(40)      ,/* 元件料號 */
bmbb004       varchar2(10)      ,/* 部位編號 */
bmbb005       timestamp(0)      ,/* 生效日期時間 */
bmbb007       varchar2(10)      ,/* 作業編號 */
bmbb008       varchar2(10)      ,/* 製程段號 */
bmbb009       number(20,6)      ,/* 起始生產數量 */
bmbb010       number(20,6)      ,/* 截止生產數量 */
bmbb011       number(20,6)      ,/* 變動損耗率 */
bmbb012       number(20,6)      ,/* 固定損耗量 */
bmbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmbb_t add constraint bmbb_pk primary key (bmbbent,bmbbsite,bmbb001,bmbb002,bmbb003,bmbb004,bmbb005,bmbb007,bmbb008,bmbb009) enable validate;

create unique index bmbb_pk on bmbb_t (bmbbent,bmbbsite,bmbb001,bmbb002,bmbb003,bmbb004,bmbb005,bmbb007,bmbb008,bmbb009);

grant select on bmbb_t to tiptop;
grant update on bmbb_t to tiptop;
grant delete on bmbb_t to tiptop;
grant insert on bmbb_t to tiptop;

exit;
