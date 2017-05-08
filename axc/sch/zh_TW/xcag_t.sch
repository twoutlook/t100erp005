/* 
================================================================================
檔案代號:xcag_t
檔案名稱:物料標準成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcag_t
(
xcagent       number(5)      ,/* 企業編號 */
xcagsite       varchar2(10)      ,/* 營運據點 */
xcagcomp       varchar2(10)      ,/* 法人組織 */
xcag001       varchar2(80)      ,/* 標準成本分類 */
xcag002       date      ,/* 生效日期 */
xcag003       date      ,/* 失效日期 */
xcag004       varchar2(40)      ,/* 物料編碼 */
xcag010       varchar2(10)      ,/* 版本 */
xcag011       varchar2(10)      ,/* 幣別 */
xcag102       number(20,6)      ,/* 標準單位成本 */
xcag102a       number(20,6)      ,/* 單位成本-材料 */
xcag102b       number(20,6)      ,/* 單位成本-人工 */
xcag102c       number(20,6)      ,/* 單位成本-委外 */
xcag102d       number(20,6)      ,/* 單位成本-制費一 */
xcag102e       number(20,6)      ,/* 單位成本-制費二 */
xcag102f       number(20,6)      ,/* 單位成本-制費三 */
xcag102g       number(20,6)      ,/* 單位成本-制費四 */
xcag102h       number(20,6)      ,/* 單位成本-制費五 */
xcag104a       number(20,6)      ,/* 本階-材料 */
xcag104b       number(20,6)      ,/* 本階-人工 */
xcag104c       number(20,6)      ,/* 本階-委外 */
xcag104d       number(20,6)      ,/* 本階-制費一 */
xcag104e       number(20,6)      ,/* 本階-制費二 */
xcag104f       number(20,6)      ,/* 本階-制費三 */
xcag104g       number(20,6)      ,/* 本階-制費四 */
xcag104h       number(20,6)      ,/* 本階-制費五 */
xcag106a       number(20,6)      ,/* 下階-材料 */
xcag106b       number(20,6)      ,/* 下階-人工 */
xcag106c       number(20,6)      ,/* 下階-委外 */
xcag106d       number(20,6)      ,/* 下階-制費一 */
xcag106e       number(20,6)      ,/* 下階-制費二 */
xcag106f       number(20,6)      ,/* 下階-制費三 */
xcag106g       number(20,6)      ,/* 下階-制費四 */
xcag106h       number(20,6)      ,/* 下階-制費五 */
xcagownid       varchar2(20)      ,/* 資料所有者 */
xcagowndp       varchar2(10)      ,/* 資料所屬部門 */
xcagcrtid       varchar2(20)      ,/* 資料建立者 */
xcagcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcagcrtdt       timestamp(0)      ,/* 資料創建日 */
xcagmodid       varchar2(20)      ,/* 資料修改者 */
xcagmoddt       timestamp(0)      ,/* 最近修改日 */
xcagstus       varchar2(10)      ,/* 狀態碼 */
xcagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcag_t add constraint xcag_pk primary key (xcagent,xcagsite,xcag001,xcag002,xcag004) enable validate;

create  index xcag_n1 on xcag_t (xcagsite,xcagcomp,xcag001,xcag011);
create unique index xcag_pk on xcag_t (xcagent,xcagsite,xcag001,xcag002,xcag004);

grant select on xcag_t to tiptop;
grant update on xcag_t to tiptop;
grant delete on xcag_t to tiptop;
grant insert on xcag_t to tiptop;

exit;
