/* 
================================================================================
檔案代號:ooan_t
檔案名稱:日匯率資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ooan_t
(
ooanent       number(5)      ,/* 企業編號 */
ooan001       varchar2(5)      ,/* 匯率參照表號 */
ooan002       varchar2(10)      ,/* 交易幣別 */
ooan003       varchar2(10)      ,/* 基礎幣別 */
ooan004       date      ,/* 日期 */
ooan005       number(20,10)      ,/* 銀行買入匯率 */
ooan006       number(20,10)      ,/* 銀行賣出匯率 */
ooan007       number(20,10)      ,/* 銀行中價匯率 */
ooan008       number(20,10)      ,/* 海關買入匯率 */
ooan009       number(20,10)      ,/* 海關賣出匯率 */
ooan010       timestamp(0)      ,/* 更新時間 */
ooan011       varchar2(10)      ,/* 更新方式 */
ooan012       number(20,6)      ,/* 交易貨幣批量 */
ooan013       varchar2(10)      ,/* 匯率輸入方式 */
ooanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooan_t add constraint ooan_pk primary key (ooanent,ooan001,ooan002,ooan003,ooan004) enable validate;

create unique index ooan_pk on ooan_t (ooanent,ooan001,ooan002,ooan003,ooan004);

grant select on ooan_t to tiptop;
grant update on ooan_t to tiptop;
grant delete on ooan_t to tiptop;
grant insert on ooan_t to tiptop;

exit;
