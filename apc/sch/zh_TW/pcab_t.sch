/* 
================================================================================
檔案代號:pcab_t
檔案名稱:收銀人員基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table pcab_t
(
pcabent       number(5)      ,/* 企業編號 */
pcabunit       varchar2(10)      ,/* 應用組織 */
pcab001       varchar2(10)      ,/* 收銀人員編號 */
pcab002       varchar2(20)      ,/* 員工編號 */
pcab003       varchar2(80)      ,/* 收銀人員姓名 */
pcab004       varchar2(10)      ,/* 所屬組織 */
pcab005       varchar2(10)      ,/* 所屬部門 */
pcab006       varchar2(10)      ,/* 職能 */
pcab007       varchar2(10)      ,/* 權限編號 */
pcab008       varchar2(40)      ,/* 密碼 */
pcab009       number(10,0)      ,/* 密碼修改次數 */
pcab010       timestamp(0)      ,/* 密碼最後修改日期 */
pcab011       varchar2(1)      ,/* 是否強行登入 */
pcab012       number(20,6)      ,/* 最大折扣率 */
pcabstamp       timestamp(5)      ,/* 時間戳記 */
pcabownid       varchar2(20)      ,/* 資料所有者 */
pcabowndp       varchar2(10)      ,/* 資料所屬部門 */
pcabcrtid       varchar2(20)      ,/* 資料建立者 */
pcabcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcabcrtdt       timestamp(0)      ,/* 資料創建日 */
pcabmodid       varchar2(20)      ,/* 資料修改者 */
pcabmoddt       timestamp(0)      ,/* 最近修改日 */
pcabstus       varchar2(10)      ,/* 狀態碼 */
pcabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pcab013       varchar2(20)      ,/* 電話 */
pcab014       varchar2(80)      ,/* 郵件 */
pcab015       varchar2(10)      /* 商戶編號 */
);
alter table pcab_t add constraint pcab_pk primary key (pcabent,pcab001) enable validate;

create unique index pcab_pk on pcab_t (pcabent,pcab001);

grant select on pcab_t to tiptop;
grant update on pcab_t to tiptop;
grant delete on pcab_t to tiptop;
grant insert on pcab_t to tiptop;

exit;
