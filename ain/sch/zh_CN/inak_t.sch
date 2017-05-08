/* 
================================================================================
檔案代號:inak_t
檔案名稱:參考單位/產品包裝庫存交易明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inak_t
(
inakent       number(5)      ,/* 企業編號 */
inaksite       varchar2(10)      ,/* 營運據點 */
inak001       varchar2(20)      ,/* 單據編號 */
inak002       number(10,0)      ,/* 項次 */
inak003       number(10,0)      ,/* 項序 */
inak004       number(5,0)      ,/* 出入庫碼 */
inak005       varchar2(40)      ,/* 類型 */
inak006       varchar2(40)      ,/* 料件編號 */
inak007       varchar2(256)      ,/* 產品特徵 */
inak008       varchar2(30)      ,/* 庫存管理特徵 */
inak009       varchar2(10)      ,/* 庫位編號 */
inak010       varchar2(10)      ,/* 儲位編號 */
inak011       varchar2(30)      ,/* 批號 */
inak012       varchar2(40)      ,/* 參考單位/包裝編號 */
inak013       number(20,6)      ,/* 交易數量 */
inak014       number(20,6)      ,/* 交易單位與庫存單位換算率 */
inak015       number(20,6)      ,/* 交易單位與料件基本單位換算率 */
inak016       varchar2(20)      ,/* 異動命令代號 */
inak017       date      ,/* 單據扣帳日期 */
inak018       date      ,/* 實際執行扣帳日期 */
inak019       varchar2(8)      ,/* 資料產生時間 */
inak020       varchar2(20)      ,/* 異動資料產生者 */
inakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inak_t add constraint inak_pk primary key (inakent,inaksite,inak001,inak002,inak003,inak004,inak005) enable validate;

create unique index inak_pk on inak_t (inakent,inaksite,inak001,inak002,inak003,inak004,inak005);

grant select on inak_t to tiptop;
grant update on inak_t to tiptop;
grant delete on inak_t to tiptop;
grant insert on inak_t to tiptop;

exit;
