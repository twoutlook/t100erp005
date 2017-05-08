/* 
================================================================================
檔案代號:pcax_t
檔案名稱:暫時離機操作日誌檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcax_t
(
pcaxent       number(5)      ,/* 企業代碼 */
pcaxsite       varchar2(10)      ,/* 營運據點 */
pcax001       varchar2(20)      ,/* 離機編號 */
pcax002       varchar2(10)      ,/* 機號 */
pcax003       date      ,/* 營業日期 */
pcax004       varchar2(10)      ,/* 班次 */
pcax005       varchar2(20)      ,/* 操作人員 */
pcax006       varchar2(10)      ,/* 操作類型 */
pcax007       date      ,/* 系統日期 */
pcax008       varchar2(8)      ,/* 系統時間 */
pcax009       varchar2(8)      ,/* 離機時長 */
pcax010       varchar2(20)      ,/* 關聯離機編號 */
pcax011       varchar2(1)      ,/* 訓練模式否 */
pcaxacti       varchar2(1)      ,/* 資料有效碼 */
pcaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcax_t add constraint pcax_pk primary key (pcaxent,pcaxsite,pcax001) enable validate;

create unique index pcax_pk on pcax_t (pcaxent,pcaxsite,pcax001);

grant select on pcax_t to tiptop;
grant update on pcax_t to tiptop;
grant delete on pcax_t to tiptop;
grant insert on pcax_t to tiptop;

exit;
