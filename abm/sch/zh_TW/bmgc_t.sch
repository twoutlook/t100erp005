/* 
================================================================================
檔案代號:bmgc_t
檔案名稱:BOM群組替代量組合檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmgc_t
(
bmgcent       number(5)      ,/* 企業編號 */
bmgcsite       varchar2(10)      ,/* 營運據點 */
bmgc001       varchar2(40)      ,/* 主件料號 */
bmgc002       varchar2(30)      ,/* 特性 */
bmgc003       varchar2(10)      ,/* 替代群組 */
bmgc004       varchar2(40)      ,/* 階層主件料號 */
bmgc005       varchar2(40)      ,/* 替代料號 */
bmgc006       varchar2(10)      ,/* 部位 */
bmgc007       varchar2(10)      ,/* 作業編號 */
bmgc008       varchar2(10)      ,/* 製程式 */
bmgc009       number(20,6)      ,/* 組成用量 */
bmgc010       number(20,6)      ,/* 主件底數 */
bmgc011       varchar2(10)      ,/* 單位 */
bmgcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmgcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmgcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmgcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmgcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmgcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmgcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmgcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmgcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmgcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmgcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmgcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmgcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmgcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmgcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmgcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmgcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmgcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmgcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmgcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmgcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmgcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmgcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmgcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmgcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmgcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmgcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmgcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmgcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmgcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bmgc012       varchar2(1)      ,/* 主要 */
bmgc013       varchar2(1)      /* 保稅否 */
);
alter table bmgc_t add constraint bmgc_pk primary key (bmgcent,bmgcsite,bmgc001,bmgc002,bmgc003,bmgc004,bmgc005,bmgc006,bmgc007,bmgc008) enable validate;

create unique index bmgc_pk on bmgc_t (bmgcent,bmgcsite,bmgc001,bmgc002,bmgc003,bmgc004,bmgc005,bmgc006,bmgc007,bmgc008);

grant select on bmgc_t to tiptop;
grant update on bmgc_t to tiptop;
grant delete on bmgc_t to tiptop;
grant insert on bmgc_t to tiptop;

exit;
