/* 
================================================================================
檔案代號:bmcf_t
檔案名稱:元件限定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmcf_t
(
bmcfent       number(5)      ,/* 企業編號 */
bmcfsite       varchar2(10)      ,/* 營運據點 */
bmcf001       varchar2(40)      ,/* 主件料號 */
bmcf002       varchar2(30)      ,/* 特性代碼 */
bmcf003       varchar2(40)      ,/* 元件料號 */
bmcf004       varchar2(10)      ,/* 部位編號 */
bmcf005       timestamp(0)      ,/* 生效日期時間 */
bmcf007       varchar2(10)      ,/* 作業編號 */
bmcf008       varchar2(10)      ,/* 製程段號 */
bmcf009       varchar2(30)      ,/* 限定特徵 */
bmcf010       number(10,0)      ,/* 項次 */
bmcf011       varchar2(30)      ,/* 特徵起始值 */
bmcf012       varchar2(30)      ,/* 特徵終止值 */
bmcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmcf_t add constraint bmcf_pk primary key (bmcfent,bmcfsite,bmcf001,bmcf002,bmcf003,bmcf004,bmcf005,bmcf007,bmcf008,bmcf009,bmcf010) enable validate;

create  index bmcf_01 on bmcf_t (bmcf001,bmcf002,bmcf003,bmcf004,bmcf005,bmcf007,bmcf008,bmcf009,bmcf010);
create unique index bmcf_pk on bmcf_t (bmcfent,bmcfsite,bmcf001,bmcf002,bmcf003,bmcf004,bmcf005,bmcf007,bmcf008,bmcf009,bmcf010);

grant select on bmcf_t to tiptop;
grant update on bmcf_t to tiptop;
grant delete on bmcf_t to tiptop;
grant insert on bmcf_t to tiptop;

exit;
