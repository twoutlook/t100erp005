/* 
================================================================================
檔案代號:xcbf_t
檔案名稱:成本域範圍設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbf_t
(
xcbfent       number(5)      ,/* 企業編號 */
xcbfownid       varchar2(20)      ,/* 資料所有者 */
xcbfowndp       varchar2(10)      ,/* 資料所有部門 */
xcbfcrtid       varchar2(20)      ,/* 資料建立者 */
xcbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbfcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbfmodid       varchar2(20)      ,/* 資料修改者 */
xcbfmoddt       timestamp(0)      ,/* 最近修改日 */
xcbfstus       varchar2(10)      ,/* 狀態碼 */
xcbfcomp       varchar2(10)      ,/* 法人組織 */
xcbf001       varchar2(10)      ,/* 成本域編號 */
xcbf002       varchar2(10)      ,/* 組織/倉庫編號 */
xcbf003       varchar2(1)      ,/* 成本域類型 */
xcbf004       varchar2(1)      ,/* 成本計算類型 */
xcbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbf_t add constraint xcbf_pk primary key (xcbfent,xcbfcomp,xcbf001,xcbf002) enable validate;

create unique index xcbf_pk on xcbf_t (xcbfent,xcbfcomp,xcbf001,xcbf002);

grant select on xcbf_t to tiptop;
grant update on xcbf_t to tiptop;
grant delete on xcbf_t to tiptop;
grant insert on xcbf_t to tiptop;

exit;
