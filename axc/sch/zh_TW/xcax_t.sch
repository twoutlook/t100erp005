/* 
================================================================================
檔案代號:xcax_t
檔案名稱:物料與成本次要素對應主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcax_t
(
xcaxent       number(5)      ,/* 企業編號 */
xcaxownid       varchar2(20)      ,/* 資料所有者 */
xcaxowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaxcrtid       varchar2(20)      ,/* 資料建立者 */
xcaxcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaxcrtdt       timestamp(0)      ,/* 資料創建日 */
xcaxmodid       varchar2(20)      ,/* 資料修改者 */
xcaxmoddt       timestamp(0)      ,/* 最近修改日 */
xcaxstus       varchar2(10)      ,/* 狀態碼 */
xcaxsite       varchar2(10)      ,/* 營運據點 */
xcax001       varchar2(40)      ,/* 料號 */
xcax002       varchar2(10)      ,/* 成本次要素 */
xcaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcax_t add constraint xcax_pk primary key (xcaxent,xcaxsite,xcax001) enable validate;

create unique index xcax_pk on xcax_t (xcaxent,xcaxsite,xcax001);

grant select on xcax_t to tiptop;
grant update on xcax_t to tiptop;
grant delete on xcax_t to tiptop;
grant insert on xcax_t to tiptop;

exit;
