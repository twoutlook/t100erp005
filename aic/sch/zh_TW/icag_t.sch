/* 
================================================================================
檔案代號:icag_t
檔案名稱:多角貿易計價方式設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table icag_t
(
icagent       number(5)      ,/* 企業編號 */
icagsite       varchar2(10)      ,/* 營運據點 */
icag001       varchar2(10)      ,/* 流程編號 */
icag002       date      ,/* 生效日期 */
icag003       number(5,0)      ,/* 站別 */
icag004       varchar2(10)      ,/* 營運據點 */
icag005       varchar2(10)      ,/* 計價方式 */
icag006       varchar2(10)      ,/* 計價基準 */
icag007       number(20,6)      ,/* 採購計價比率 */
icag008       varchar2(10)      ,/* 採購幣別 */
icagownid       varchar2(20)      ,/* 資料所有者 */
icagowndp       varchar2(10)      ,/* 資料所屬部門 */
icagcrtid       varchar2(20)      ,/* 資料建立者 */
icagcrtdp       varchar2(10)      ,/* 資料建立部門 */
icagcrtdt       timestamp(0)      ,/* 資料創建日 */
icagmodid       varchar2(20)      ,/* 資料修改者 */
icagmoddt       timestamp(0)      ,/* 最近修改日 */
icagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table icag_t add constraint icag_pk primary key (icagent,icag001,icag002,icag003) enable validate;

create unique index icag_pk on icag_t (icagent,icag001,icag002,icag003);

grant select on icag_t to tiptop;
grant update on icag_t to tiptop;
grant delete on icag_t to tiptop;
grant insert on icag_t to tiptop;

exit;
