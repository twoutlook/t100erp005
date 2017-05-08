/* 
================================================================================
檔案代號:faap_t
檔案名稱:底稿卡片資料記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faap_t
(
faapent       number(5)      ,/* 企業編碼 */
faap000       varchar2(10)      ,/* 底稿批號 */
faap001       varchar2(10)      ,/* 底稿卡片批號 */
faap002       varchar2(20)      ,/* 底稿編號 */
faap003       varchar2(20)      ,/* 底稿附號 */
faap004       varchar2(20)      ,/* 項目編號 */
faap005       varchar2(30)      ,/* WBS */
faap006       varchar2(10)      ,/* 財編批號 */
faap007       varchar2(20)      ,/* 資產卡片編號 */
faap008       varchar2(20)      ,/* 財產編號 */
faap009       varchar2(20)      ,/* 附號 */
faapownid       varchar2(20)      ,/* 資料所有者 */
faapowndp       varchar2(10)      ,/* 資料所屬部門 */
faapcrtid       varchar2(20)      ,/* 資料建立者 */
faapcrtdp       varchar2(10)      ,/* 資料建立部門 */
faapcrtdt       timestamp(0)      ,/* 資料創建日 */
faapmodid       varchar2(20)      ,/* 資料修改者 */
faapmoddt       timestamp(0)      ,/* 最近修改日 */
faapstus       varchar2(10)      ,/* 狀態碼 */
faapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faap_t add constraint faap_pk primary key (faapent,faap001,faap002,faap003,faap007,faap008,faap009) enable validate;

create unique index faap_pk on faap_t (faapent,faap001,faap002,faap003,faap007,faap008,faap009);

grant select on faap_t to tiptop;
grant update on faap_t to tiptop;
grant delete on faap_t to tiptop;
grant insert on faap_t to tiptop;

exit;
