/* 
================================================================================
檔案代號:stcx_t
檔案名稱:市場推廣申請資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stcx_t
(
stcxent       number(5)      ,/* 企業編號 */
stcxunit       varchar2(10)      ,/* 應用組織 */
stcxsite       varchar2(10)      ,/* 營運據點 */
stcxdocno       varchar2(20)      ,/* 單據編號 */
stcxdocdt       date      ,/* 單據日期 */
stcx001       varchar2(30)      ,/* 活動計劃 */
stcx002       varchar2(10)      ,/* 檔案類型 */
stcx003       varchar2(10)      ,/* 活動等級 */
stcx004       varchar2(20)      ,/* 申請人員 */
stcx005       varchar2(10)      ,/* 部門編號 */
stcx006       date      ,/* 開始日期 */
stcx007       date      ,/* 結束日期 */
stcx008       varchar2(20)      ,/* 合約編號 */
stcx009       varchar2(10)      ,/* 經銷商編號 */
stcx010       varchar2(10)      ,/* 幣別 */
stcx011       varchar2(10)      ,/* 稅別 */
stcxstus       varchar2(10)      ,/* 狀態碼 */
stcxownid       varchar2(20)      ,/* 資料所有者 */
stcxowndp       varchar2(10)      ,/* 資料所屬部門 */
stcxcrtid       varchar2(20)      ,/* 資料建立者 */
stcxcrtdp       varchar2(10)      ,/* 資料建立部門 */
stcxcrtdt       timestamp(0)      ,/* 資料創建日 */
stcxmodid       varchar2(20)      ,/* 資料修改者 */
stcxmoddt       timestamp(0)      ,/* 最近修改日 */
stcxcnfid       varchar2(20)      ,/* 資料確認者 */
stcxcnfdt       timestamp(0)      ,/* 資料確認日 */
stcxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcx_t add constraint stcx_pk primary key (stcxent,stcxdocno) enable validate;

create unique index stcx_pk on stcx_t (stcxent,stcxdocno);

grant select on stcx_t to tiptop;
grant update on stcx_t to tiptop;
grant delete on stcx_t to tiptop;
grant insert on stcx_t to tiptop;

exit;
