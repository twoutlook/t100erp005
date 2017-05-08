/* 
================================================================================
檔案代號:bmcd_t
檔案名稱:特徵對應單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmcd_t
(
bmcdent       number(5)      ,/* 企業編號 */
bmcdsite       varchar2(10)      ,/* 營運據點 */
bmcd001       varchar2(40)      ,/* 主件料號 */
bmcd002       varchar2(30)      ,/* 特性代碼 */
bmcd003       varchar2(40)      ,/* 元件料號 */
bmcd004       varchar2(10)      ,/* 部位編號 */
bmcd005       timestamp(0)      ,/* 生效日期時間 */
bmcd007       varchar2(10)      ,/* 作業編號 */
bmcd008       varchar2(10)      ,/* 製程段號 */
bmcd009       varchar2(30)      ,/* 對應特徵 */
bmcd010       varchar2(30)      ,/* 主件特徵值 */
bmcd011       varchar2(30)      ,/* 元件特徵值 */
bmcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmcd_t add constraint bmcd_pk primary key (bmcdent,bmcdsite,bmcd001,bmcd002,bmcd003,bmcd004,bmcd005,bmcd007,bmcd008,bmcd009,bmcd010) enable validate;

create unique index bmcd_pk on bmcd_t (bmcdent,bmcdsite,bmcd001,bmcd002,bmcd003,bmcd004,bmcd005,bmcd007,bmcd008,bmcd009,bmcd010);

grant select on bmcd_t to tiptop;
grant update on bmcd_t to tiptop;
grant delete on bmcd_t to tiptop;
grant insert on bmcd_t to tiptop;

exit;
