/* 
================================================================================
檔案代號:bmcc_t
檔案名稱:特徵對應單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmcc_t
(
bmccent       number(5)      ,/* 企業編號 */
bmccsite       varchar2(10)      ,/* 營運據點 */
bmcc001       varchar2(40)      ,/* 主件料號 */
bmcc002       varchar2(30)      ,/* 料件特性 */
bmcc003       varchar2(40)      ,/* 元件料號 */
bmcc004       varchar2(10)      ,/* 部位編號 */
bmcc005       timestamp(0)      ,/* 生效日期時間 */
bmcc007       varchar2(10)      ,/* 作業編號 */
bmcc008       varchar2(10)      ,/* 製程段號 */
bmcc009       varchar2(30)      ,/* 對應特徵 */
bmcc010       varchar2(10)      ,/* 對應方式 */
bmccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmcc_t add constraint bmcc_pk primary key (bmccent,bmccsite,bmcc001,bmcc002,bmcc003,bmcc004,bmcc005,bmcc007,bmcc008,bmcc009) enable validate;

create unique index bmcc_pk on bmcc_t (bmccent,bmccsite,bmcc001,bmcc002,bmcc003,bmcc004,bmcc005,bmcc007,bmcc008,bmcc009);

grant select on bmcc_t to tiptop;
grant update on bmcc_t to tiptop;
grant delete on bmcc_t to tiptop;
grant insert on bmcc_t to tiptop;

exit;
