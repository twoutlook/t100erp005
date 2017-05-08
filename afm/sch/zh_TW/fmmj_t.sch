/* 
================================================================================
檔案代號:fmmj_t
檔案名稱:投資購買檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmj_t
(
fmmjent       number(5)      ,/* 企業編號 */
fmmjsite       varchar2(10)      ,/* 投資組織 */
fmmjdocno       varchar2(20)      ,/* 投資購買單號 */
fmmjdocdt       date      ,/* 日期 */
fmmj001       varchar2(20)      ,/* 投資審核單號 */
fmmj002       varchar2(10)      ,/* 交易市場編號 */
fmmj003       varchar2(10)      ,/* 投資種類 */
fmmj004       varchar2(20)      ,/* 投資標的 */
fmmj005       number(20,6)      ,/* 購買數量 */
fmmj006       varchar2(10)      ,/* 幣別 */
fmmj007       number(20,6)      ,/* 單價 */
fmmj008       number(20,6)      ,/* 金額 */
fmmj009       number(20,10)      ,/* 對主本幣匯率 */
fmmj010       varchar2(1)      ,/* 質押狀態 */
fmmj011       varchar2(1)      ,/* 支付方式 */
fmmj012       varchar2(15)      ,/* 出款銀行 */
fmmj013       varchar2(30)      ,/* 出款帳戶 */
fmmj014       varchar2(20)      ,/* 來源利息單號 */
fmmj015       number(20,6)      ,/* 已宣告未發放股利 */
fmmj016       number(20,6)      ,/* 已到期未領取利息 */
fmmj017       number(20,6)      ,/* 總面值 */
fmmj018       number(15,3)      ,/* 票面年利率 */
fmmj019       varchar2(1)      ,/* 複利計算 */
fmmj020       varchar2(1)      ,/* 利息支付方式 */
fmmj021       date      ,/* 債券到期日 */
fmmj022       number(5,0)      ,/* 計息天數 */
fmmj023       varchar2(1)      ,/* 利息自動轉為本金 */
fmmjownid       varchar2(20)      ,/* 資料所有者 */
fmmjowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmjcrtid       varchar2(20)      ,/* 資料建立者 */
fmmjcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmjcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmjmodid       varchar2(20)      ,/* 資料修改者 */
fmmjmoddt       timestamp(0)      ,/* 最近修改日 */
fmmjcnfid       varchar2(20)      ,/* 資料確認者 */
fmmjcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmjpstid       varchar2(20)      ,/* 資料過帳者 */
fmmjpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmjstus       varchar2(10)      ,/* 狀態碼 */
fmmjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmj024       date      ,/* 首次利息支付日 */
fmmj025       varchar2(10)      ,/* 存提碼 */
fmmj026       varchar2(10)      ,/* 現金變動碼 */
fmmj027       varchar2(255)      ,/* 摘要 */
fmmj028       number(20,6)      ,/* 本幣金額 */
fmmj029       number(20,6)      ,/* 已宣告未發放股利本幣金額 */
fmmj030       number(20,6)      ,/* 已到期未領取利息本幣金額 */
fmmj031       number(20,6)      /* 總面值本幣金額 */
);
alter table fmmj_t add constraint fmmj_pk primary key (fmmjent,fmmjdocno) enable validate;

create unique index fmmj_pk on fmmj_t (fmmjent,fmmjdocno);

grant select on fmmj_t to tiptop;
grant update on fmmj_t to tiptop;
grant delete on fmmj_t to tiptop;
grant insert on fmmj_t to tiptop;

exit;
