/* 
================================================================================
檔案代號:isay_t
檔案名稱:發票簿異動記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isay_t
(
isayent       number(5)      ,/* 企業編碼 */
isaycomp       varchar2(10)      ,/* 法人編號 */
isaysite       varchar2(10)      ,/* 組織編號 */
isay001       varchar2(10)      ,/* 發票簿號 */
isay002       date      ,/* 發票簿可使用起始日 */
isay003       date      ,/* 發票簿可使用終止日 */
isay004       varchar2(2)      ,/* 發票類型 */
isay005       varchar2(10)      ,/* 發票聯別 */
isay006       varchar2(1)      ,/* 發票開立方式 */
isay007       varchar2(1)      ,/* 電子發票否 */
isay008       varchar2(20)      ,/* 發票字軌 */
isay009       varchar2(20)      ,/* 發票代碼 */
isay010       varchar2(20)      ,/* 起始號碼 */
isay011       varchar2(20)      ,/* 結束號碼 */
isay012       number(5,0)      ,/* 發票張數 */
isay013       number(5,0)      ,/* 已開立張數 */
isay014       varchar2(1)      ,/* 異動狀態碼 */
isay015       timestamp(0)      ,/* 異動時間 */
isay016       timestamp(0)      ,/* 傳輸時間 */
isay017       varchar2(10)      ,/* 取用門市 */
isay018       number(5,0)      ,/* 年度 */
isay019       number(5,0)      ,/* 起始月份 */
isay020       number(5,0)      ,/* 結束月份 */
isay021       varchar2(1)      ,/* 來源類型 */
isaystus       varchar2(1)      ,/* 狀態碼 */
isayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isay_t add constraint isay_pk primary key (isayent,isaycomp,isaysite,isay001,isay002,isay003) enable validate;

create unique index isay_pk on isay_t (isayent,isaycomp,isaysite,isay001,isay002,isay003);

grant select on isay_t to tiptop;
grant update on isay_t to tiptop;
grant delete on isay_t to tiptop;
grant insert on isay_t to tiptop;

exit;
