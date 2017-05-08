/* 
================================================================================
檔案代號:faag_t
檔案名稱:多部門折舊費用分攤單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table faag_t
(
faagent       number(5)      ,/* 企業編號 */
faagld       varchar2(5)      ,/* 帳套別編碼 */
faag001       number(5,0)      ,/* 資料年度 */
faag002       number(5,0)      ,/* 資料月份 */
faag003       varchar2(10)      ,/* 分攤類別 */
faag004       number(10,0)      ,/* 項次 */
faag005       varchar2(24)      ,/* 分攤部門 */
faag006       varchar2(24)      ,/* 折舊費用科目 */
faag007       number(20,6)      ,/* 分攤比率 */
faag008       number(10)      ,/* 變動比率類型 */
faag009       varchar2(24)      ,/* 變動比率分子科目 */
faag010       number(5,0)      ,/* 變動數值 */
faagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faag_t add constraint faag_pk primary key (faagent,faagld,faag001,faag002,faag003,faag004) enable validate;

create unique index faag_pk on faag_t (faagent,faagld,faag001,faag002,faag003,faag004);

grant select on faag_t to tiptop;
grant update on faag_t to tiptop;
grant delete on faag_t to tiptop;
grant insert on faag_t to tiptop;

exit;
