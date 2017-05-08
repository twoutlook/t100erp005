/* 
================================================================================
檔案代號:stie_t
檔案名稱:招商租賃合約申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stie_t
(
stieent       number(5)      ,/* 企業編號 */
stiesite       varchar2(10)      ,/* 營運組織 */
stieunit       varchar2(10)      ,/* 制定組織 */
stiedocdt       date      ,/* 單據日期 */
stiedocno       varchar2(20)      ,/* 單據編號 */
stie000       varchar2(10)      ,/* 作業類型 */
stie001       varchar2(20)      ,/* 合約編號 */
stie002       varchar2(10)      ,/* 版本 */
stie003       varchar2(20)      ,/* 合約項編號 */
stie004       varchar2(10)      ,/* 經營方式 */
stie005       varchar2(10)      ,/* 合約狀態 */
stie006       varchar2(20)      ,/* 檔案編號 */
stie007       varchar2(10)      ,/* 商戶編號 */
stie008       varchar2(20)      ,/* 鋪位編號 */
stie009       varchar2(10)      ,/* 租賃類型 */
stie010       varchar2(255)      ,/* 門牌號 */
stie011       date      ,/* 租賃開始日期 */
stie012       date      ,/* 租賃結束日期 */
stie013       number(10,0)      ,/* 免租天數 */
stie014       varchar2(1)      ,/* 首零合併 */
stie015       varchar2(1)      ,/* 尾零合併 */
stie016       date      ,/* 簽訂日期 */
stie017       varchar2(20)      ,/* 簽訂人員 */
stie018       varchar2(10)      ,/* 簽訂部門 */
stie019       varchar2(10)      ,/* 樓棟編號 */
stie020       varchar2(10)      ,/* 樓層編號 */
stie021       varchar2(10)      ,/* 區域編號 */
stie022       varchar2(10)      ,/* 鋪位用途 */
stie023       number(20,6)      ,/* 建築面積 */
stie024       number(20,6)      ,/* 測量面積 */
stie025       number(20,6)      ,/* 經營面積 */
stie026       number(10,0)      ,/* 人數 */
stie027       varchar2(10)      ,/* no use */
stie028       varchar2(10)      ,/* 管理品類 */
stie029       varchar2(10)      ,/* 經營主品牌 */
stie030       varchar2(10)      ,/* 結算組織 */
stie031       varchar2(10)      ,/* 結算方式 */
stie032       varchar2(10)      ,/* 結算類型 */
stie033       varchar2(10)      ,/* 收銀方式 */
stie034       varchar2(10)      ,/* 付款條件 */
stie035       varchar2(10)      ,/* 交易條件 */
stie036       varchar2(10)      ,/* 幣別 */
stie037       varchar2(10)      ,/* 匯率計算基準 */
stie038       varchar2(10)      ,/* 稅別 */
stie039       varchar2(10)      ,/* 發票類型 */
stie040       varchar2(1)      ,/* 含發票否 */
stie041       date      ,/* 執行日期 */
stie042       date      ,/* 進場日期 */
stie043       date      ,/* 延期日期 */
stie044       date      ,/* 原合約開始日期 */
stie045       date      ,/* 清退日期 */
stie046       date      ,/* 作廢日期 */
stie047       date      ,/* 蓋章日期 */
stie048       varchar2(20)      ,/* 預租協議 */
stie049       varchar2(255)      ,/* 備註 */
stie223       number(20,6)      ,/* 原建築面積 */
stie224       number(20,6)      ,/* 原測量面積 */
stie225       number(20,6)      ,/* 原經營面積 */
stiestus       varchar2(10)      ,/* 狀態碼 */
stieownid       varchar2(20)      ,/* 資料所有者 */
stieowndp       varchar2(10)      ,/* 資料所屬部門 */
stiecrtid       varchar2(20)      ,/* 資料建立者 */
stiecrtdp       varchar2(10)      ,/* 資料建立部門 */
stiecrtdt       timestamp(0)      ,/* 資料創建日 */
stiemodid       varchar2(20)      ,/* 資料修改者 */
stiemoddt       timestamp(0)      ,/* 最近修改日 */
stiecnfid       varchar2(20)      ,/* 資料確認者 */
stiecnfdt       timestamp(0)      ,/* 資料確認日 */
stieud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stieud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stieud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stieud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stieud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stieud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stieud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stieud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stieud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stieud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stieud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stieud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stieud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stieud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stieud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stieud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stieud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stieud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stieud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stieud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stieud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stieud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stieud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stieud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stieud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stieud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stieud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stieud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stieud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stieud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stie050       date      ,/* 初審異動日期 */
stie051       varchar2(20)      ,/* 初審異動人員 */
stie052       date      ,/* 終審異動日期 */
stie053       varchar2(20)      ,/* 終審異動人員 */
stie200       varchar2(20)      /* 變更申請單號 */
);
alter table stie_t add constraint stie_pk primary key (stieent,stiedocno) enable validate;

create unique index stie_pk on stie_t (stieent,stiedocno);

grant select on stie_t to tiptop;
grant update on stie_t to tiptop;
grant delete on stie_t to tiptop;
grant insert on stie_t to tiptop;

exit;
