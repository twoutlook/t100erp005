/* 
================================================================================
檔案代號:mhbg_t
檔案名稱:商戶記錄資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mhbg_t
(
mhbgent       number(5)      ,/* 企業編號 */
mhbgsite       varchar2(10)      ,/* 營運據點 */
mhbgunit       varchar2(10)      ,/* 應用組織 */
mhbgdocno       varchar2(20)      ,/* 單據編號 */
mhbgdocdt       date      ,/* 單據日期 */
mhbg000       varchar2(20)      ,/* 作業編號 */
mhbg001       varchar2(10)      ,/* 商戶編號 */
mhbg002       varchar2(1)      ,/* 法人類型 */
mhbg003       varchar2(10)      ,/* 所屬法人 */
mhbg004       varchar2(10)      ,/* 所屬集團 */
mhbg005       varchar2(10)      ,/* 註冊國家 */
mhbg006       varchar2(20)      ,/* 公司登記證號 */
mhbg007       varchar2(80)      ,/* 負責人 */
mhbg008       date      ,/* 創業日 */
mhbg009       number(20,6)      ,/* 資本額 */
mhbg010       varchar2(10)      ,/* 資本額計算幣別 */
mhbg011       number(10,0)      ,/* 員工人數 */
mhbg012       number(20,6)      ,/* 年營業額 */
mhbg013       varchar2(10)      ,/* 年營業額計算幣別 */
mhbg014       varchar2(10)      ,/* 產業分類 */
mhbg015       varchar2(10)      ,/* 規模分類 */
mhbg016       varchar2(255)      ,/* 主要經營產品 */
mhbg017       varchar2(10)      ,/* 資料來源 */
mhbg018       varchar2(10)      ,/* 供應商生命週期 */
mhbg019       varchar2(10)      ,/* 重要性等級 */
mhbg020       date      ,/* 開發日期 */
mhbg021       date      ,/* 立戶日期 */
mhbg022       varchar2(1)      ,/* 策略聯盟否 */
mhbg023       varchar2(10)      ,/* 供應商角色 */
mhbg024       varchar2(10)      ,/* 供應商通路 */
mhbg025       varchar2(10)      ,/* 供應商合作模式 */
mhbg026       varchar2(10)      ,/* 慣用經營方式 */
mhbg027       varchar2(10)      ,/* 慣用結算方式 */
mhbg028       varchar2(10)      ,/* 慣用交易幣別 */
mhbg029       varchar2(10)      ,/* 慣用交易稅別 */
mhbg030       varchar2(10)      ,/* 慣用發票開立方式 */
mhbg031       varchar2(2)      ,/* 慣用發票類型 */
mhbg032       varchar2(10)      ,/* 慣用應付款類型 */
mhbg033       varchar2(10)      ,/* 慣用應收帳款類型 */
mhbg034       varchar2(20)      ,/* 來源單號 */
mhbg035       varchar2(20)      ,/* 稅務編號 */
mhbg036       number(20,6)      ,/* 預租面積 */
mhbg037       varchar2(20)      ,/* 聯絡對象識別碼 */
mhbgstus       varchar2(10)      ,/* 狀態碼 */
mhbgownid       varchar2(20)      ,/* 資料所有者 */
mhbgowndp       varchar2(10)      ,/* 資料所屬部門 */
mhbgcrtid       varchar2(20)      ,/* 資料建立者 */
mhbgcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhbgcrtdt       timestamp(0)      ,/* 資料創建日 */
mhbgmodid       varchar2(20)      ,/* 資料修改者 */
mhbgmoddt       timestamp(0)      ,/* 最近修改日 */
mhbgcnfid       varchar2(20)      ,/* 資料確認者 */
mhbgcnfdt       timestamp(0)      ,/* 資料確認日 */
mhbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mhbg038       varchar2(20)      ,/* 聯繫電話 */
mhbg039       varchar2(10)      /* 供應商類型 */
);
alter table mhbg_t add constraint mhbg_pk primary key (mhbgent,mhbgdocno) enable validate;

create unique index mhbg_pk on mhbg_t (mhbgent,mhbgdocno);

grant select on mhbg_t to tiptop;
grant update on mhbg_t to tiptop;
grant delete on mhbg_t to tiptop;
grant insert on mhbg_t to tiptop;

exit;
