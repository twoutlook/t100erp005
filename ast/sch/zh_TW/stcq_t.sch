/* 
================================================================================
檔案代號:stcq_t
檔案名稱:分銷客戶陳列協議資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stcq_t
(
stcqent       number(5)      ,/* 企業編號 */
stcqsite       varchar2(10)      ,/* 營運據點 */
stcqunit       varchar2(10)      ,/* 應用組織 */
stcqdocno       varchar2(20)      ,/* 單據編號 */
stcqdocdt       date      ,/* 單據日期 */
stcq001       varchar2(20)      ,/* 合約編號 */
stcq002       varchar2(10)      ,/* 客戶類型 */
stcq003       varchar2(10)      ,/* 經銷商編號 */
stcq004       varchar2(10)      ,/* 網點編號 */
stcq005       varchar2(10)      ,/* 經營方式 */
stcq006       varchar2(10)      ,/* 結算方式 */
stcq007       varchar2(10)      ,/* 結算類型 */
stcq008       varchar2(20)      ,/* 人員 */
stcq009       varchar2(10)      ,/* 部門 */
stcq010       varchar2(10)      ,/* 結算中心 */
stcq011       varchar2(10)      ,/* 銷售組織 */
stcq012       varchar2(10)      ,/* 銷售範圍 */
stcq013       varchar2(10)      ,/* 銷售通路 */
stcq014       varchar2(10)      ,/* 產品組 */
stcq015       varchar2(10)      ,/* 辦事處 */
stcq016       varchar2(10)      ,/* 幣別 */
stcq017       varchar2(10)      ,/* 稅目 */
stcq018       date      ,/* 開始日期 */
stcq019       date      ,/* 截止日期 */
stcqstus       varchar2(10)      ,/* 狀態碼 */
stcqownid       varchar2(20)      ,/* 資料所有者 */
stcqowndp       varchar2(10)      ,/* 資料所屬部門 */
stcqcrtid       varchar2(20)      ,/* 資料建立者 */
stcqcrtdp       varchar2(10)      ,/* 資料建立部門 */
stcqcrtdt       timestamp(0)      ,/* 資料創建日 */
stcqmodid       varchar2(20)      ,/* 資料修改者 */
stcqmoddt       timestamp(0)      ,/* 最近修改日 */
stcqcnfid       varchar2(20)      ,/* 資料確認者 */
stcqcnfdt       timestamp(0)      ,/* 資料確認日 */
stcqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcq_t add constraint stcq_pk primary key (stcqent,stcqdocno) enable validate;

create unique index stcq_pk on stcq_t (stcqent,stcqdocno);

grant select on stcq_t to tiptop;
grant update on stcq_t to tiptop;
grant delete on stcq_t to tiptop;
grant insert on stcq_t to tiptop;

exit;
