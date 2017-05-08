/* 
================================================================================
檔案代號:gldj_t
檔案名稱:合併報表會計科目沖銷規則資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldj_t
(
gldjent       number(5)      ,/* 企業代碼 */
gldj001       varchar2(10)      ,/* 下層/上層公司(來源公司) */
gldj002       varchar2(5)      ,/* 帳別/合併帳別(來源公司) */
gldj003       varchar2(10)      ,/* 下層/上層公司(對沖公司) */
gldj004       varchar2(5)      ,/* 帳別/合併帳別(對沖公司) */
gldj005       varchar2(10)      ,/* 上層公司(合併主體) */
gldj006       varchar2(5)      ,/* 合併帳別(合併主體) */
gldj007       number(10,0)      ,/* 沖銷組別序號 */
gldj008       varchar2(1)      ,/* 股本沖銷否 */
gldj009       varchar2(1)      ,/* 彙總方式(來源公司) */
gldj010       varchar2(24)      ,/* 會計科目編號 (來源公司) */
gldj011       varchar2(1)      ,/* 彙總方式(對沖公司) */
gldj012       varchar2(24)      ,/* 會計科目編號 (對沖公司) */
gldj013       varchar2(1)      ,/* 核算項對沖方式(來源公司) */
gldj014       varchar2(1)      ,/* 核算項對沖方式(對沖公司) */
gldj015       varchar2(1)      ,/* 差額處理方式 */
gldj016       varchar2(24)      ,/* 借方差額科目 */
gldj017       varchar2(24)      ,/* 貸方差額科目 */
gldjownid       varchar2(20)      ,/* 資料所有者 */
gldjowndp       varchar2(10)      ,/* 資料所屬部門 */
gldjcrtid       varchar2(20)      ,/* 資料建立者 */
gldjcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldjcrtdt       timestamp(0)      ,/* 資料創建日 */
gldjmodid       varchar2(20)      ,/* 資料修改者 */
gldjmoddt       timestamp(0)      ,/* 最近修改日 */
gldjstus       varchar2(10)      ,/* 狀態碼 */
gldjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gldj018       varchar2(10)      ,/* 核算項(來源公司) */
gldj019       varchar2(10)      /* 核算項(對沖公司) */
);
alter table gldj_t add constraint gldj_pk primary key (gldjent,gldj001,gldj002,gldj003,gldj004,gldj005,gldj006,gldj007,gldj010,gldj012) enable validate;

create unique index gldj_pk on gldj_t (gldjent,gldj001,gldj002,gldj003,gldj004,gldj005,gldj006,gldj007,gldj010,gldj012);

grant select on gldj_t to tiptop;
grant update on gldj_t to tiptop;
grant delete on gldj_t to tiptop;
grant insert on gldj_t to tiptop;

exit;
